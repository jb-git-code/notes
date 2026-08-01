import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:frontend/core/local/hive_boxes.dart';
import 'package:frontend/features/constants/appColors.dart';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(_readInitial()) {
    AppColors.setDark(state);
  }

  static bool _readInitial() {
    final box = Hive.box(HiveBoxes.settings);
    return box.get('isDark', defaultValue: false) as bool;
  }

  Future<void> toggle() async {
    state = !state;
    AppColors.setDark(state);
    await Hive.box(HiveBoxes.settings).put('isDark', state);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});