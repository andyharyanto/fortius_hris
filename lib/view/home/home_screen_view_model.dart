import 'package:flutter/cupertino.dart';

import '../../model/login/login_response.dart';

class HomeScreenViewModel extends ChangeNotifier {
  LoginResponseDataUser? userData;

  LoginResponseDataUser? get getUserData => userData;

  setUserData(LoginResponseDataUser? data) {
    userData = data;
    notifyListeners();
  }
}
