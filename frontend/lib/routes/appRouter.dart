import 'package:frontend/features/auth/screens/authGate.dart';
import 'package:frontend/features/auth/screens/loginScreen.dart';
import 'package:frontend/features/auth/screens/registerScreen.dart';
import 'package:frontend/features/notes/screens/home/home_page.dart';
import 'package:frontend/routes/appRoutes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.splash,

    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const AuthGate(),
      ),
    ],
  );
}
