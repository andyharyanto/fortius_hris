import 'package:fortius_hris/service/navigation/navigation_service.dart';
import 'package:get_it/get_it.dart';

import 'network/api_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerSingleton<ApiRepository>(ApiRepository());
}