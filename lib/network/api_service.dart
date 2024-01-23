import 'package:dio/dio.dart';
import 'package:fortius_hris/common/constant.dart';
import 'package:retrofit/http.dart';

import '../model/login/login_request.dart';
import '../model/login/login_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "")
abstract class ApiService {
  factory ApiService(Dio dio, {required String baseUrl}) = _ApiService;

  @POST(loginApi)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);
}
