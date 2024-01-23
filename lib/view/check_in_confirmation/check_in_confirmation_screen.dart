import 'dart:io';

import 'package:fortius_hris/common/styles.dart';
import 'package:fortius_hris/helper/helper.dart';
import 'package:fortius_hris/view/check_in_confirmation/check_in_confirmation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fortius_hris/app.dart';
import 'package:fortius_hris/widget/fortius_app_bar.dart';
import 'package:fortius_hris/widget/fortius_long_button.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../common/colors.dart';
import '../../widget/fortius_live_clock.dart';

class CheckInConfirmationScreen extends StatefulWidget {
  final String checkInFilePath;

  const CheckInConfirmationScreen({super.key, required this.checkInFilePath});

  @override
  State<CheckInConfirmationScreen> createState() =>
      _CheckInConfirmationScreenState();
}

class _CheckInConfirmationScreenState extends State<CheckInConfirmationScreen> {
  late final String checkInFilePath;

  late CheckInConfirmationViewModel viewModel;

  @override
  void initState() {
    checkInFilePath = widget.checkInFilePath;

    viewModel =
        Provider.of<CheckInConfirmationViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.getCurrentLocation();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckInConfirmationViewModel>(builder: (_, model, child) {
      return Scaffold(
        appBar: FortiusAppBar(
            titleBar: "Check In",
            onLeadingPressed: () {
              Navigator.pop(context);
            }),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: 200,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Image.file(File(checkInFilePath)),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: darkBluePrimary,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.door_back_door_outlined,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText()
                            .textNormal("Check in as: ")
                            .textColor(Colors.white),
                        CustomText()
                            .textNormal(App.getProfile()?.name ?? "")
                            .textColor(Colors.white),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: darkBluePrimary,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        FortiusLiveClockWidget()
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        CustomText()
                            .textNormal(Helper.convertDateFormat(
                                DateTime.now().toString()))
                            .textColor(Colors.white)
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    viewModel.getIsLoadingGetLocation
                        ? shimmerBanner()
                        : Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  viewModel.getCurrentFullAddress ?? "",
                                  style: const TextStyle(color: Colors.white),
                                  maxLines: 2,
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: FortiusLongButton(
                    buttonText: "Check In",
                    onButtonPress: () {
                      viewModel.saveCheckInCheckOut(checkInFilePath);
                    },
                    disabled: viewModel.getIsLoadingGetLocation,
                    isLoading: false),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget shimmerBanner() {
    return Shimmer.fromColors(
        period: const Duration(milliseconds: 1000),
        baseColor: darkBluePrimary,
        highlightColor: Colors.white,
        child: Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                20.0,
              ),
            )));
  }
}
