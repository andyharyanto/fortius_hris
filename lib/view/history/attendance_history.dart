import 'package:flutter/material.dart';
import 'package:fortius_hris/common/colors.dart';
import 'package:fortius_hris/common/constant.dart';
import 'package:fortius_hris/common/styles.dart';
import 'package:fortius_hris/helper/helper.dart';
import 'package:fortius_hris/locator.dart';
import 'package:fortius_hris/service/navigation/route_names.dart';
import 'package:fortius_hris/widget/fortius_app_bar.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../model/local/boxes.dart';
import '../../model/local/check_in_model.dart';
import '../../service/navigation/navigation_service.dart';
import '../../widget/line_separator.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  final NavigationService _navigationService = locator<NavigationService>();

  int selectedIndex = 0;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    selectedIndex = DateTime.now().day - 1;

    Future.delayed(Duration.zero, () {
      _scrollController.scrollTo(
          index: selectedIndex, duration: Duration(milliseconds: 500));
    });

    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != now) {
      setState(() {
        now = picked;
        lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
        selectedIndex = picked.day - 1;
        _scrollController.scrollTo(
            index: selectedIndex, duration: Duration(milliseconds: 500));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FortiusAppBar(
        titleBar: "Attendance",
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        onActionPressed: () {
          _selectDate(context);
        },
      ),
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Row(
                    children: [
                      CustomText().textBold(now.day.toString()).fontSize(40),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText()
                              .textBold(DateFormat('EEE').format(now))
                              .fontSize(12),
                          CustomText()
                              .textBold(
                                  "${DateFormat('MMM').format(now)} ${DateFormat('y').format(now)} ")
                              .fontSize(12),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 90,
                      child: ScrollablePositionedList.builder(
                        scrollDirection: Axis.horizontal,
                        itemScrollController: _scrollController,
                        itemCount: lastDayOfMonth.day,
                        itemBuilder: (context, index) {
                          final currentDate =
                              lastDayOfMonth.add(Duration(days: index + 1));
                          final dayName = DateFormat('E').format(currentDate);
                          return Container(
                            padding: EdgeInsets.only(
                                left: index == 0 ? 16.0 : 0.0, right: 16.0),
                            child: GestureDetector(
                              onTap: () => setState(() {
                                selectedIndex = index;
                                now = DateTime(lastDayOfMonth.year,
                                    lastDayOfMonth.month, index + 1);
                              }),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 30.0,
                                      width: 30.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: selectedIndex == index
                                            ? darkBluePrimary
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(44.0),
                                      ),
                                      child: CustomText()
                                          .textBold(dayName.substring(0, 1))
                                          .textColor(selectedIndex == index
                                              ? Colors.white
                                              : darkBluePrimary)
                                          .fontSize(16)),
                                  const SizedBox(height: 8.0),
                                  CustomText()
                                      .textBold("${index + 1}")
                                      .textColor(darkBluePrimary)
                                      .fontSize(16),
                                  const SizedBox(height: 8.0),
                                  Container(
                                    height: 2.0,
                                    width: 28.0,
                                    color: selectedIndex == index
                                        ? darkBluePrimary
                                        : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ValueListenableBuilder<Box<CheckInModel>>(
                    valueListenable: Boxes.getListCheckIn().listenable(),
                    builder: (context, box, _) {
                      var listCheckIn = box.values
                          .toList()
                          .cast<CheckInModel>()
                          .where((element) =>
                              element.date ==
                              DateUtils.dateOnly(now).toString())
                          .toList();

                      return listCheckIn.isEmpty
                          ? Center(child: CustomText().textNormal("No Data"))
                          : ListView.builder(
                              itemCount: listCheckIn.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return attendanceHistoryItem(
                                    listCheckIn[index]);
                              });
                    }))
          ],
        ),
      ),
    );
  }

  Widget attendanceHistoryItem(CheckInModel? data) {
    return InkWell(
      onTap: () {
        _navigationService.navigateTo(attendanceHistoryDetailScreenRoute,
            arguments: {'dataAttendance': data});
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: Colors.grey, width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.ac_unit,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText()
                                .textBold(data?.userName ?? "")
                                .fontSize(16),
                            Text(
                              data?.companyId ?? "",
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                //status
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 2, bottom: 2),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: lightGrey),
                      child: CustomText()
                          .textBold(data?.status ?? "Unknown")
                          .fontSize(12)
                          .textColor(data?.status == statusAbsent ||
                                  data?.status == statusEarlyCheckOut
                              ? Colors.red
                              : data?.status == statusOvertime ||
                                      data?.status == statusPresent
                                  ? Colors.green
                                  : Colors.black)
                          .alignment(Alignment.center)),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            CustomText()
                .textBold(data?.durationInHrMin ?? "-")
                .fontSize(12)
                .alignment(Alignment.center),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: CustomText()
                            .textBold(Helper.convertDateFormatJustTime(
                                data?.checkInTime ?? ""))
                            .textAlignment(TextAlign.end))),
                Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                10,
                              )),
                              color: Colors.grey),
                        ),
                        const Expanded(
                            child: LineSeparator(
                          color: Colors.grey,
                          height: 1,
                        )),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                10,
                              )),
                              color: Colors.grey),
                        ),
                      ],
                    )),
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 12),
                        child: CustomText().textBold(
                            Helper.convertDateFormatJustTime(
                                data?.checkOutTime ?? ""))))
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: bluePrimary,
                            ),
                            Expanded(
                              child: Text(
                                data?.checkInPlaceMark ?? "",
                                style: const TextStyle(
                                    color: bluePrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ))),
                const Spacer(),
                Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: bluePrimary,
                        ),
                        Text(
                          data?.checkOutPlaceMark ?? "-",
                          style: const TextStyle(
                              color: bluePrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        )
                      ],
                    )),
              ],
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: lightGrey,
              margin: const EdgeInsets.only(top: 12, bottom: 12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText()
                    .textBold("See Details")
                    .fontSize(12)
                    .textColor(bluePrimary),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: bluePrimary,
                  size: 16,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
