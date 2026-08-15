import 'package:freezed_annotation/freezed_annotation.dart';

import 'userModel.dart';

part 'loginResponse.freezed.dart';
part 'loginResponse.g.dart';

@freezed
abstract class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required bool success,
    required String message,
    required String token,
    required UserModel data,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
