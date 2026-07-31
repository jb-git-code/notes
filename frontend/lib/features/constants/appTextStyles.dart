import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/features/constants/appColors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Crafty Girls — handwritten, playful, used for titles
  static TextStyle headingLarge = GoogleFonts.craftyGirls(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
    height: 1.3,
  );

  static TextStyle headingSmall = GoogleFonts.craftyGirls(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
    height: 1.3,
  );

  // Manrope — elegant, clean sans for body/subtitle text
  static TextStyle bodyLarge = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.manrope(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
    height: 1.5,
  );

  static TextStyle labelMedium = GoogleFonts.manrope(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
    height: 1.2,
  );

  static TextStyle buttonText = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );
}