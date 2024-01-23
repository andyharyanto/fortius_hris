import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "status")
  int? status = 0;

  @JsonKey(name: "success")
  bool? success = false;

  @JsonKey(name: "data")
  LoginResponseData? data;

  LoginResponse({this.status, this.success, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class LoginResponseData {
  @JsonKey(name: "user")
  LoginResponseDataUser? user;

  @JsonKey(name: "token")
  String? token = "";

  @JsonKey(name: "token_type")
  String? tokenType = "";

  @JsonKey(name: "expires_at")
  String? expiresAt = "";

  LoginResponseData({this.user, this.token, this.tokenType, this.expiresAt});

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);
}

@JsonSerializable()
class LoginResponseDataUser {
  @JsonKey(name: "id")
  String? id = "";

  @JsonKey(name: "name")
  String? name = "";

  @JsonKey(name: "email")
  String? email = "";

  @JsonKey(name: "role")
  String? role = "";

  @JsonKey(name: "company_id")
  String? companyId = "";

  @JsonKey(name: "company")
  UserCompanyData? userCompanyData;

  LoginResponseDataUser(
      {this.id,
      this.name,
      this.email,
      this.role,
      this.companyId,
      this.userCompanyData});

  factory LoginResponseDataUser.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataUserFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDataUserToJson(this);
}

@JsonSerializable()
class UserCompanyData {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "company_name")
  String? companyName = "";

  UserCompanyData({this.id, this.companyName});

  factory UserCompanyData.fromJson(Map<String, dynamic> json) =>
      _$UserCompanyDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserCompanyDataToJson(this);
}
