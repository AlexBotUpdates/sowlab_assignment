import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get titleLarge => GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get title => GoogleFonts.outfit(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyLarge => GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyMedium => GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get subtitle => GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get hint => GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary.withOpacity(0.5),
      );

  static TextStyle get buttonText => GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.textWhite,
      );

  static TextStyle get linkText => GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.onboardingTerracotta,
        decoration: TextDecoration.none,
      );

  static TextStyle get forgotText => GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.onboardingTerracotta,
      );

  static TextStyle get labelSmall => GoogleFonts.outfit(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary.withAlpha(128),
      );
}
