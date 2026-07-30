import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Core palette (from reference image swatches, left to right)
  static const Color periwinkle = Color(0xFFD1DEEA); // soft blue
  static const Color mint = Color(0xFFD2E4E3);       // pale mint
  static const Color mintAlt = Color(0xFFD2E4E3);    // duplicate swatch in source
  static const Color sage = Color(0xFFADCEC6);        // sage green
  static const Color slateGrey = Color(0xFF9FA8B3);   // estimated — verify hex

  // Semantic aliases — use these in widgets instead of raw palette names
  static const Color primary = sage;
  static const Color secondary = periwinkle;
  static const Color tertiary = mint;
  static const Color accentGrey = slateGrey;

  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF7FAF9);
  static const Color surfaceMuted = mint;

  static const Color textPrimary = Color(0xFF2B3A3A);
  static const Color textSecondary = Color(0xFF6B7D7C);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color divider = Color(0xFFE3ECEA);
  static const Color error = Color(0xFFE0796B);
}