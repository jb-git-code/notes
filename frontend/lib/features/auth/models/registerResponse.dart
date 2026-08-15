import 'package:freezed_annotation/freezed_annotation.dart';

import 'userModel.dart';

part 'registerResponse.freezed.dart';
part 'registerResponse.g.dart';

@freezed
abstract class RegisterResponse with _$RegisterResponse {
  const factory RegisterResponse({
    required bool success,
    required String message,
    required UserModel data,
  }) = _RegisterResponse;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}
