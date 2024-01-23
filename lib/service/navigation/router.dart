import 'package:flutter/material.dart';
import 'package:fortius_hris/model/local/check_in_model.dart';
import 'package:fortius_hris/service/navigation/route_names.dart';
import 'package:fortius_hris/view/check_in_confirmation/check_in_confirmation_screen.dart';
import 'package:fortius_hris/view/history/attendance_history.dart';
import 'package:fortius_hris/view/history/attendance_history_detail.dart';
import 'package:fortius_hris/view/home/home_screen.dart';
import 'package:fortius_hris/view/login/login_screen.dart';
import 'package:fortius_hris/view/splash/splash_screen.dart';

PageRoute _getPageRoute(
    {required String routeName, required Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashScreenRoute:
      return _getPageRoute(
          routeName: settings.name ?? "", viewToShow: const SplashScreen());

    case loginScreenRoute:
      return _getPageRoute(
          routeName: settings.name ?? "", viewToShow: const LoginScreen());

    case homeScreenRoute:
      return _getPageRoute(
          routeName: settings.name ?? "", viewToShow: const HomeScreen());

    case attendanceHistoryScreenRoute:
      return _getPageRoute(
          routeName: settings.name ?? "",
          viewToShow: const AttendanceHistoryScreen());

    case attendanceHistoryDetailScreenRoute:
      Map mapObject = (settings.arguments ?? <String, dynamic>{}) as Map;
      CheckInModel? dataAttendance = mapObject['dataAttendance'];
      return _getPageRoute(
          routeName: settings.name ?? "",
          viewToShow: AttendanceHistoryDetailScreen(
            dataAttendance: dataAttendance,
          ));

    case checkInConfirmationScreenRoute:
      Map mapObject = (settings.arguments ?? <String, dynamic>{}) as Map;
      String checkInFilePath = mapObject['checkInFilePath'];

      return _getPageRoute(
          routeName: settings.name ?? "",
          viewToShow:
              CheckInConfirmationScreen(checkInFilePath: checkInFilePath));

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body:
                    Center(child: Text('No route found for ${settings.name}')),
              ));
  }
}
