// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      status: json['status'] as int?,
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : LoginResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'data': instance.data,
    };

LoginResponseData _$LoginResponseDataFromJson(Map<String, dynamic> json) =>
    LoginResponseData(
      user: json['user'] == null
          ? null
          : LoginResponseDataUser.fromJson(
              json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
      tokenType: json['token_type'] as String?,
      expiresAt: json['expires_at'] as String?,
    );

Map<String, dynamic> _$LoginResponseDataToJson(LoginResponseData instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'token_type': instance.tokenType,
      'expires_at': instance.expiresAt,
    };

LoginResponseDataUser _$LoginResponseDataUserFromJson(
        Map<String, dynamic> json) =>
    LoginResponseDataUser(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      companyId: json['company_id'] as String?,
      userCompanyData: json['company'] == null
          ? null
          : UserCompanyData.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseDataUserToJson(
        LoginResponseDataUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'company_id': instance.companyId,
      'company': instance.userCompanyData,
    };

UserCompanyData _$UserCompanyDataFromJson(Map<String, dynamic> json) =>
    UserCompanyData(
      id: json['id'] as String?,
      companyName: json['company_name'] as String?,
    );

Map<String, dynamic> _$UserCompanyDataToJson(UserCompanyData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_name': instance.companyName,
    };
