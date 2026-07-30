// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    _LoginResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      token: json['token'] as String,
      data: UserModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(_LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'token': instance.token,
      'data': instance.data,
    };
