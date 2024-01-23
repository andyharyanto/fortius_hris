import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

import 'common/constant.dart';
import 'model/login/login_response.dart';

class App {
  static GetStorage getStorageLogin() {
    return GetStorage(loginStorage);
  }

  static GetStorage getStorageProfile() {
    return GetStorage(profileStorage);
  }

  static bool boolIsGotoHomeScreen() {
    var g = getStorageLogin();
    final String? existingToken = g.read(accessToken);
    return (existingToken != null && existingToken != "");
  }

  static void setAccessToken(String token) async {
    var g = getStorageLogin();
    await g.write(accessToken, token);
  }

  static Future<void> setUserData(LoginResponseDataUser? data) async {
    try {
      if (data != null) {
        var profileString = jsonEncode(data.toJson());
        await GetStorage(profileStorage).write(profileData, profileString);
      }
    } catch (e) {
      debugPrint("Error set user data: $e");
    }
  }

  static LoginResponseDataUser? getProfile() {
    var g = GetStorage(profileStorage);
    String? profileString = g.read(profileData);
    LoginResponseDataUser? storedProfile;
    try {
      if (profileString != null && profileString != "") {
        storedProfile =
            LoginResponseDataUser.fromJson(jsonDecode(profileString));
      }
    } catch (e) {
      debugPrint("Error get user data: $e");
    }

    return storedProfile ?? LoginResponseDataUser();
  }
}
