import 'package:flutter/cupertino.dart';
import 'package:fortius_hris/app.dart';
import 'package:fortius_hris/locator.dart';
import 'package:fortius_hris/service/navigation/route_names.dart';
import 'package:intl/intl.dart';

import '../model/local/boxes.dart';
import '../service/navigation/navigation_service.dart';

class Helper {
  static String convertDateFormat(String date) {
    return DateFormat(
      "EEE, dd MMMM yyyy",
    ).format(DateTime.parse(date));
  }

  static String convertDateFormatJustTime(String date) {
    if (date == "") return "-:-";

    return DateFormat("HH:mm").format(DateTime.parse(date));
  }

  static String convertDateFormatTimeToSecond(String date) {
    if (date == "") return "-:-";

    return DateFormat('HH:mm:ss').format(DateTime.parse(date));
  }

  static Future logout(BuildContext context) async {
    var storageLogin = App.getStorageLogin();
    var storageProfile = App.getStorageProfile();
    var dbListAttendance = Boxes.getListCheckIn();

    await storageLogin.erase();
    await storageProfile.erase();
    await dbListAttendance.clear();

    locator<NavigationService>().navigatePushAndRemoveUntil(loginScreenRoute);
  }
}

extension StringExt on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
