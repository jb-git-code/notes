import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static bool _isDark = false;
  static bool get isDark => _isDark;

  static void setDark(bool isDark) {
    _isDark = isDark;
  }

  // ---- Light palette (Forest minimal) ----
  static const _lightBackground = Color(0xFFF2F6F1);
  static const _lightSurface = Color(0xFFFFFFFF);
  static const _lightPrimary = Color(0xFF2F6D4F);
  static const _lightAccent = Color(0xFF6FAE8C);
  static const _lightText = Color(0xFF1B2E22);
  static const _lightTextSecondary = Color(0xFF5A6B60);
  static const _lightTextOnPrimary = Color(0xFFFFFFFF);
  static const _lightDivider = Color(0xFFDCE5DD);
  static const _lightSuccess = Color(0xFF22C55E);
  static const _lightDanger = Color(0xFFE76F51);

  // ---- Dark palette ----
  static const _darkBackground = Color(0xFF141B17);
  static const _darkSurface = Color(0xFF1D2A23);
  static const _darkPrimary = Color(0xFF6FAE8C);
  static const _darkAccent = Color(0xFF8FC7A9);
  static const _darkText = Color(0xFFEAF2EC);
  static const _darkTextSecondary = Color(0xFFA9BBB1);
  static const _darkTextOnPrimary = Color(0xFF10201A);
  static const _darkDivider = Color(0xFF2C3B33);
  static const _darkSuccess = Color(0xFF4ADE80);
  static const _darkDanger = Color(0xFFEF8767);

  static Color get background => _isDark ? _darkBackground : _lightBackground;
  static Color get surface => _isDark ? _darkSurface : _lightSurface;
  static Color get primary => _isDark ? _darkPrimary : _lightPrimary;
  static Color get accent => _isDark ? _darkAccent : _lightAccent;
  static Color get text => _isDark ? _darkText : _lightText;
  static Color get textSecondary =>
      _isDark ? _darkTextSecondary : _lightTextSecondary;
  static Color get textOnPrimary =>
      _isDark ? _darkTextOnPrimary : _lightTextOnPrimary;
  static Color get divider => _isDark ? _darkDivider : _lightDivider;
  static Color get success => _isDark ? _darkSuccess : _lightSuccess;
  static Color get danger => _isDark ? _darkDanger : _lightDanger;
}
