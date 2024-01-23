import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fortius_hris/common/colors.dart';
import 'package:fortius_hris/common/styles.dart';
import 'package:fortius_hris/helper/helper.dart';
import 'package:fortius_hris/model/local/check_in_model.dart';
import 'package:fortius_hris/widget/fortius_app_bar.dart';
import 'package:styled_widget/styled_widget.dart';

class AttendanceHistoryDetailScreen extends StatefulWidget {
  final CheckInModel? dataAttendance;

  const AttendanceHistoryDetailScreen(
      {super.key, required this.dataAttendance});

  @override
  State<AttendanceHistoryDetailScreen> createState() =>
      _AttendanceHistoryDetailScreenState();
}

class _AttendanceHistoryDetailScreenState
    extends State<AttendanceHistoryDetailScreen> {
  late CheckInModel? dataAttendance;

  @override
  void initState() {
    dataAttendance = widget.dataAttendance;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FortiusAppBar(
        titleBar: "Attendance Details",
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(35),
                  child: Container(
                    color: Colors.black,
                    child: const Icon(
                      Icons.ac_unit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomText()
                  .textBold(dataAttendance?.userName ?? "")
                  .fontSize(16),
              CustomText()
                  .textNormal(dataAttendance?.companyId ?? "")
                  .textColor(Colors.grey),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText()
                      .textBold("Total Check In")
                      .textColor(Colors.grey),
                  CustomText()
                      .textBold(
                          "${dataAttendance?.documentList.length} Check in/out(s)")
                      .textColor(Colors.grey),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText().textBold("Date").textColor(Colors.grey),
                  CustomText()
                      .textBold(
                          Helper.convertDateFormat(dataAttendance?.date ?? ""))
                      .textColor(Colors.grey),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText().textBold("Status").textColor(Colors.grey),
                  CustomText()
                      .textBold(dataAttendance?.status ?? "")
                      .textColor(Colors.grey),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                height: 3,
                color: lightGrey,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText().textBold("Duration").textColor(Colors.grey),
                  CustomText()
                      .textBold(dataAttendance?.durationInHrMin ?? "")
                      .textColor(Colors.grey),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                height: 1,
                color: lightGrey,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText().textBold("Check In").textColor(Colors.grey),
                  CustomText()
                      .textBold(Helper.convertDateFormatJustTime(
                          dataAttendance?.checkInTime ?? ""))
                      .textColor(Colors.grey),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText().textBold("Location").textColor(Colors.grey),
                  const SizedBox(width: 16,),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: bluePrimary,
                      ),
                      Text(
                          dataAttendance?.checkInPlaceMark ?? "-",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: bluePrimary),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                height: 1,
                color: lightGrey,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText().textBold("Check Out").textColor(Colors.grey),
                  CustomText()
                      .textBold(Helper.convertDateFormatJustTime(
                          dataAttendance?.checkOutTime ?? ""))
                      .textColor(Colors.grey),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText().textBold("Location").textColor(Colors.grey),
                  const SizedBox(width: 16,),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: bluePrimary,
                      ),
                      Text(
                        dataAttendance?.checkOutPlaceMark ?? "-",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: bluePrimary),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                height: 1,
                color: lightGrey,
              ),
              const SizedBox(
                height: 12,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText()
                    .textBold("Documentations")
                    .textColor(Colors.grey),
              ),
              const SizedBox(
                height: 12,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: 135,
                    child: ListView.builder(
                        itemCount: dataAttendance?.documentList.length ?? 0,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        margin: const EdgeInsets.all(16),
                                        child: Image.file(
                                          File(dataAttendance
                                                  ?.documentList[index] ??
                                              ""),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              width: 100,
                              margin: const EdgeInsets.only(right: 12),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                child: Image.file(
                                  File(dataAttendance?.documentList[index] ??
                                      ""),
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
