import 'package:flutter/material.dart';
import 'package:sowlab_app/core/theme/app_colors.dart';
import 'package:sowlab_app/core/theme/app_text_styles.dart';
import 'package:sowlab_app/core/theme/app_radius.dart';

class AuthPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const AuthPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.onboardingTerracotta,
          foregroundColor: AppColors.textWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: AppColors.textWhite,
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: AppTextStyles.buttonText,
              ),
      ),
    );
  }
}
