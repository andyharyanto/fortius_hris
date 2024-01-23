import 'dart:io';

import 'package:dio/dio.dart';

String helperErrorApi(Object e) {
  var message = "";
  if (e is DioException) {
    if (e.response == null) {
      message = "Please check your connection.";
      return message;
    }
    try {
      if (e.response!.statusCode! > 400 && e.response!.statusCode! < 500) {
        if (e.response!.statusCode == 401) {
          message = "Wrong email or password, please check again.";
        }
      } else if (e.response!.statusCode! >= 500) {
        message = "Something went wrong, please try again.";
      } else {
        message = "Connection lost, please try again.";
      }
    } catch (e) {
      return message = "Something went wrong, please try again.";
    }

    return message;
  } else if (e is SocketException) {
    message = "No internet connection";
    return message;
  } else {
    return message = "Something went wrong, please try again.";
  }
}
