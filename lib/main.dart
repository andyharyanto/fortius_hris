import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fortius_hris/common/constant.dart';
import 'package:fortius_hris/model/local/check_in_model.dart';
import 'package:fortius_hris/service/navigation/navigation_service.dart';
import 'package:fortius_hris/service/navigation/route_names.dart';
import 'package:fortius_hris/service/navigation/router.dart';
import 'package:fortius_hris/view/check_in_confirmation/check_in_confirmation_view_model.dart';
import 'package:fortius_hris/view/home/home_screen_view_model.dart';
import 'package:fortius_hris/view/login/login_view_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'locator.dart';

void main() {
  runZonedGuarded(() async {
    await GetStorage.init(loginStorage);
    await GetStorage.init(profileStorage);

    var appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    //adapter declare
    Hive.registerAdapter(CheckInModelAdapter()); //0

    //hive db
    await Hive.openBox<CheckInModel>('Check_In');

    setupLocator();
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => HomeScreenViewModel()),
        ChangeNotifierProvider(create: (_) => CheckInConfirmationViewModel())
      ],
      child: const FortiusHrisApp(),
    ));
  }, (error, stack) {});
}

class FortiusHrisApp extends StatelessWidget {
  const FortiusHrisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: MaterialApp(
        navigatorKey: locator<NavigationService>().navigationKey,
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: ThemeData(
          fontFamily: 'Blueberry',
          primaryColor: Colors.white,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
          }),
        ),
        initialRoute: splashScreenRoute,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
