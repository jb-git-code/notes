import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:frontend/core/local/hive_boxes.dart';
import 'package:frontend/features/constants/appColors.dart';
import 'package:frontend/features/theme/theme_provider.dart';
import 'package:frontend/routes/appRouter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveBoxes.noteMeta);
  await Hive.openBox(HiveBoxes.settings);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    AppColors.setDark(isDark);
    return KeyedSubtree(
      key: ValueKey(isDark),
      child: MaterialApp.router(
        theme: ThemeData(
          brightness: isDark ? Brightness.dark : Brightness.light,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme(
            brightness: isDark ? Brightness.dark : Brightness.light,
            primary: AppColors.primary,
            onPrimary: AppColors.textOnPrimary,
            secondary: AppColors.accent,
            onSecondary: AppColors.textOnPrimary,
            error: AppColors.danger,
            onError: AppColors.textOnPrimary,
            surface: AppColors.surface,
            onSurface: AppColors.text,
          ),
          textTheme: TextTheme(bodyMedium: TextStyle(color: AppColors.text)),
        ),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
