import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/auth/providers/authProvider.dart';
import 'package:frontend/features/constants/appColors.dart';
import 'package:frontend/features/constants/appTextStyles.dart';
import 'package:frontend/features/theme/theme_provider.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _logOut(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Logout?', style: AppTextStyles.headingSmall),
        content: Text('This will log you out', style: AppTextStyles.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              if (ctx.mounted) Navigator.pop(ctx);
              if (context.mounted) context.go('/login');
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(
              'Yes',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.danger,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Settings', style: AppTextStyles.headingSmall),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Material(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            child: SwitchListTile(
              value: isDark,
              onChanged: (_) => ref.read(themeProvider.notifier).toggle(),
              activeColor: AppColors.primary,
              title: Text('Dark mode', style: AppTextStyles.bodyLarge),
              secondary: Icon(
                isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Material(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              onTap: () => _logOut(context, ref),
              leading: Icon(Icons.logout_rounded, color: AppColors.danger),
              title: Text(
                'Logout',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.danger,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
