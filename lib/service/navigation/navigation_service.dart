import 'package:flutter/cupertino.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigatePushReplacement(String routeName,
      {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigatePushAndRemoveUntil(String routeName,
      {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  BuildContext buildContext() {
    return navigationKey.currentContext!;
  }
}
