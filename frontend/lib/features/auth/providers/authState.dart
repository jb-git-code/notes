import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/userModel.dart';

part 'authState.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    UserModel? user,
    String? error,
  }) = _AuthState;
}