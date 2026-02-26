import 'package:flutter/material.dart';
import 'package:sowlab_app/core/theme/app_text_styles.dart';
import 'package:sowlab_app/core/theme/app_radius.dart';

class OnboardingButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const OnboardingButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
          ),
        ),
        child: Text(
          text,
          style: AppTextStyles.buttonText,
        ),
      ),
    );
  }
}
