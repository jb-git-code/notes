import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/exceptions/apiExceptions.dart';
import 'package:frontend/features/auth/providers/authState.dart';
import 'package:frontend/features/auth/repositories/authRepository.dart';

final authProvider = NotifierProvider<AuthNotifier,AuthState>(AuthNotifier.new,);

class AuthNotifier extends Notifier<AuthState> {
  final _repository = AuthRepository();

  @override
  AuthState build() {
    return const AuthState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _repository.login(
        email: email,
        password: password,
      );

      state = state.copyWith(isLoading: false, user: response.data);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: "Something went wrong.");
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState();
  }
}
