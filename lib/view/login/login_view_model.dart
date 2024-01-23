import 'package:flutter/cupertino.dart';
import 'package:fortius_hris/helper/helper_error_api.dart';
import 'package:fortius_hris/model/login/login_request.dart';
import 'package:fortius_hris/network/api_repository.dart';

import '../../app.dart';
import '../../locator.dart';
import '../../service/navigation/navigation_service.dart';
import '../../service/navigation/route_names.dart';

class LoginViewModel extends ChangeNotifier {
  var isLoading = false;
  var messageError = "";

  bool get getIsLoading => isLoading;

  String get getMessageError => messageError;

  setIsLoading(bool flag) {
    isLoading = flag;
    notifyListeners();
  }

  setMessageError(String msg) {
    messageError = msg;
    notifyListeners();
  }

  postLogin(String userEmail, String userPassword) async {
    setIsLoading(true);
    setMessageError("");
    var errMsg = "";
    try {
      bool isEmailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(userEmail);

      if (userEmail.isEmpty) {
        errMsg = "Email tidak boleh kosong";
        throw errMsg;
      } else if (!isEmailValid) {
        errMsg = "Email tidak valid";
        throw errMsg;
      } else if (userPassword.isEmpty) {
        errMsg = "Password tidak boleh kosong";
        throw errMsg;
      } else {
        setMessageError("");
      }

      var request = LoginRequest(email: userEmail, password: userPassword);
      var resultResponse =
          await locator<ApiRepository>().apiService.login(request);

      if (resultResponse.data != null) {
        if (resultResponse.data?.token != "") {
          App.setAccessToken(resultResponse.data?.token ?? "");
          App.setUserData(resultResponse.data?.user);
          locator<NavigationService>()
              .navigatePushAndRemoveUntil(homeScreenRoute);
        }
      }
    } catch (e) {
      if (errMsg.isNotEmpty) {
        setMessageError(e.toString());
      } else {
        setMessageError(helperErrorApi(e));
      }
    } finally {
      setIsLoading(false);
    }
  }
}
