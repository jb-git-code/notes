import 'package:flutter/material.dart';
import 'package:frontend/utils/appColors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle _base({
    required double fontSize,
    required FontWeight weight,
    Color color = AppColors.textPrimary,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.getFont(
      'Elms Sans',
      fontSize: fontSize,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Display / headings
  static TextStyle displayLarge = _base(
    fontSize: 32,
    weight: FontWeight.w700,
    height: 1.2,
  );
  static TextStyle displayMedium = _base(
    fontSize: 26,
    weight: FontWeight.w700,
    height: 1.25,
  );

  static TextStyle headingLarge = _base(
    fontSize: 22,
    weight: FontWeight.w600,
    height: 1.3,
  );
  static TextStyle headingMedium = _base(
    fontSize: 18,
    weight: FontWeight.w600,
    height: 1.3,
  );
  static TextStyle headingSmall = _base(
    fontSize: 16,
    weight: FontWeight.w600,
    height: 1.3,
  );

  // Body
  static TextStyle bodyLarge = _base(
    fontSize: 16,
    weight: FontWeight.w400,
    height: 1.5,
  );
  static TextStyle bodyMedium = _base(
    fontSize: 14,
    weight: FontWeight.w400,
    height: 1.5,
  );
  static TextStyle bodySmall = _base(
    fontSize: 12,
    weight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // Labels / buttons
  static TextStyle labelLarge = _base(
    fontSize: 16,
    weight: FontWeight.w500,
    letterSpacing: 0.2,
  );
  static TextStyle labelMedium = _base(
    fontSize: 14,
    weight: FontWeight.w500,
    letterSpacing: 0.2,
  );
  static TextStyle buttonText = _base(
    fontSize: 15,
    weight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    letterSpacing: 0.3,
  );

  // Captions / hints
  static TextStyle caption = _base(
    fontSize: 12,
    weight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
}
