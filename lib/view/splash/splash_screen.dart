import 'package:flutter/material.dart';

import '../../app.dart';
import '../../common/constant.dart';
import '../../locator.dart';
import '../../service/navigation/navigation_service.dart';
import '../../service/navigation/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    checkRoute();

    super.initState();
  }

  void checkRoute() {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      if (App.boolIsGotoHomeScreen()) {
        _navigationService.navigatePushAndRemoveUntil(homeScreenRoute);
      } else {
        _navigationService.navigatePushReplacement(loginScreenRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(width: 220, fit: BoxFit.cover, fortiusLogo),
      ),
    );
  }
}
