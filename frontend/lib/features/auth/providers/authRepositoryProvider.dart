import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/authRepository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});
