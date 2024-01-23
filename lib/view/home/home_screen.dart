import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fortius_hris/app.dart';
import 'package:fortius_hris/common/colors.dart';
import 'package:fortius_hris/common/constant.dart';
import 'package:fortius_hris/common/styles.dart';
import 'package:fortius_hris/helper/helper.dart';
import 'package:fortius_hris/locator.dart';
import 'package:fortius_hris/view/home/home_screen_view_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fortius_hris/service/navigation/navigation_service.dart';
import 'package:fortius_hris/service/navigation/route_names.dart';
import 'package:fortius_hris/widget/fortius_long_button.dart';
import 'package:fortius_hris/widget/line_separator.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../model/local/boxes.dart';
import '../../model/local/check_in_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NavigationService _navigationService = locator<NavigationService>();

  late DateTime todayTime;

  late HomeScreenViewModel viewModel;

  LocationPermission? locationPermission;
  Permission cameraPermission = Permission.camera;

  @override
  void initState() {
    viewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.setUserData(App.getProfile());
    });

    todayTime = DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenViewModel>(builder: (_, model, child) {
      return Scaffold(
          body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 300,
              color: darkBluePrimary,
            ),
            SafeArea(
              top: true,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      fortiusLogoWhite,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText()
                                .textBold(
                                    "Hello ${viewModel.getUserData?.name}")
                                .fontSize(20)
                                .textColor(Colors.white),
                            const SizedBox(
                              height: 4,
                            ),
                            CustomText()
                                .textBold(
                                    "${viewModel.getUserData?.role?.toCapitalized()} | ${viewModel.getUserData?.userCompanyData?.companyName}")
                                .textColor(Colors.white),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            showDialogLogout(context, () {
                              Navigator.pop(context);
                              Helper.logout(context);
                            });
                          },
                          child: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ValueListenableBuilder<Box<CheckInModel>>(
                        valueListenable: Boxes.getListCheckIn().listenable(),
                        builder: (context, box, _) {
                          var listCarts = box.values
                              .toList()
                              .cast<CheckInModel>()
                              .where((element) =>
                                  element.date ==
                                  DateUtils.dateOnly(DateTime.now()).toString())
                              .toList();

                          CheckInModel? itemToday;

                          if (listCarts.isNotEmpty) {
                            itemToday = listCarts[0];
                          }

                          return Card(
                            elevation: 4,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  color: Colors.white),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText()
                                          .textBold(Helper.convertDateFormat(
                                              todayTime.toString()))
                                          .textColor(Colors.black),
                                      FortiusLongButton(
                                        buttonText: itemToday?.checkInTime ==
                                                    null &&
                                                itemToday?.checkOutTime == null
                                            ? "Check In"
                                            : itemToday?.checkInTime != null &&
                                                    itemToday?.checkOutTime ==
                                                        null
                                                ? "Check Out"
                                                : "Done Check In/Out",
                                        onButtonPress: () async {
                                          checkLocationPermission();
                                        },
                                        disabled:
                                            itemToday?.checkInTime != null &&
                                                itemToday?.checkOutTime != null,
                                        isLoading: false,
                                        isBoxShape: true,
                                        buttonColor: itemToday?.checkInTime !=
                                                    null &&
                                                itemToday?.checkOutTime == null
                                            ? Colors.red
                                            : null,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 1,
                                    color: greyField,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText().textBold("Check In"),
                                        CustomText().textBold("Check Out")
                                      ],
                                    ),
                                  ),
                                  itemToday?.durationInHrMin != null
                                      ? CustomText().textBold(
                                          itemToday?.durationInHrMin ?? "")
                                      : CustomText()
                                          .textBold("0 hrs 0 mins")
                                          .textStyle(const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.grey)),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                              20,
                                            )),
                                            color: Colors.grey),
                                        child: const Icon(
                                          Icons.remove,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Expanded(
                                          flex: 6,
                                          child: LineSeparator(
                                            color: Colors.grey,
                                            height: 1,
                                          )),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                              20,
                                            )),
                                            color: Colors.grey),
                                        child: const Icon(
                                          Icons.remove,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                  itemToday?.status != null
                                      ? CustomText()
                                          .textBold(itemToday?.status ?? "")
                                      : CustomText().textNormal("-"),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Spacer(),
                                      itemToday?.checkInTime != null
                                          ? CustomText().textNormal(
                                              Helper.convertDateFormatJustTime(
                                                  itemToday?.checkInTime ?? ""))
                                          : CustomText().textNormal("-:-"),
                                      Expanded(flex: 6, child: Container()),
                                      itemToday?.checkOutTime != null
                                          ? CustomText().textNormal(
                                              Helper.convertDateFormatJustTime(
                                                  itemToday?.checkOutTime ??
                                                      ""))
                                          : CustomText().textNormal("-:-"),
                                      const Spacer(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Spacer(),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            color: bluePrimary,
                                          ),
                                          itemToday?.checkInPlaceMark != null
                                              ? CustomText()
                                                  .textBold(itemToday
                                                          ?.checkInPlaceMark ??
                                                      "")
                                                  .textColor(bluePrimary)
                                              : CustomText()
                                                  .textBold("-:-")
                                                  .textColor(bluePrimary)
                                        ],
                                      ),
                                      Expanded(flex: 6, child: Container()),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            color: bluePrimary,
                                          ),
                                          itemToday?.checkOutPlaceMark != null
                                              ? CustomText()
                                                  .textBold(itemToday
                                                          ?.checkOutPlaceMark ??
                                                      "")
                                                  .textColor(bluePrimary)
                                              : CustomText()
                                                  .textBold("-:-")
                                                  .textColor(bluePrimary)
                                        ],
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          _navigationService
                              .navigateTo(attendanceHistoryScreenRoute);
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              border: Border.all(color: bluePrimary, width: 2),
                              color: Colors.white),
                          child: const Icon(
                            Icons.laptop_mac,
                            color: bluePrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: CustomText()
                            .textBold("Attendance")
                            .textAlignment(TextAlign.center)),
                  ],
                ),
              ),
            )
          ],
        ),
      ));
    });
  }

  void checkLocationPermission() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      await Geolocator.openLocationSettings();
    } else {
      var status = await Permission.location.status;

      if (status.isDenied) {
        Map<Permission, PermissionStatus> permissionStatus =
            await [Permission.location].request();

        if (permissionStatus.isNotEmpty) {
          checkCameraPermission();
        } else {
          return;
        }
      } else if (await Permission.location.isPermanentlyDenied) {
        openAppSettings();
      } else if (await Permission.location.isGranted) {
        checkCameraPermission();
      }
    }
  }

  void checkCameraPermission() async {
    var statusCamera = await Permission.camera.status;
    if (statusCamera.isDenied) {
      Map<Permission, PermissionStatus> permissionCamera =
          await [Permission.camera].request();

      if (permissionCamera.isNotEmpty) {
        openCamera();
      } else {
        return;
      }
    } else if (await Permission.camera.isPermanentlyDenied) {
      openAppSettings();
    } else if (await Permission.camera.isGranted) {
      openCamera();
    }
  }

  void openCamera() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.front);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      _navigationService.navigateTo(checkInConfirmationScreenRoute,
          arguments: {'checkInFilePath': file.path});
    }
  }

  Future<void> showDialogLogout(
      BuildContext context, VoidCallback onLogoutPressed) {
    return showModalBottomSheet<void>(
        isDismissible: true,
        context: context,
        enableDrag: false,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FortiusLongButton(
                  buttonText: "Logout",
                  onButtonPress: onLogoutPressed,
                  disabled: false,
                  isLoading: false,
                  buttonColor: Colors.red,
                )
              ],
            ),
          );
        });
  }
}
