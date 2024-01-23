import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:fortius_hris/common/constant.dart';

import 'api_service.dart';

class ApiRepository {
  late final ApiService _apiService;

  late final Dio _dio;

  ApiRepository() {
    _dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(milliseconds: 6000),
        receiveTimeout: const Duration(milliseconds: 6000),
        sendTimeout: const Duration(milliseconds: 6000),
        contentType: "application/json",
        headers: {
          "app_name": applicationName,
        },
      ),
    )..interceptors.add(HttpFormatter());
    _dio.interceptors
        .add(QueuedInterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }, onError: (err, handler) async {
      return handler.next(err);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }));
    _apiService = ApiService(_dio, baseUrl: baseUrlApi);
  }

  ApiService get apiService => _apiService;
}
