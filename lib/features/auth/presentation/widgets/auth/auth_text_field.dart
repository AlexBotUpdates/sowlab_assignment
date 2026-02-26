import 'package:flutter/material.dart';
import 'package:sowlab_app/core/theme/app_colors.dart';
import 'package:sowlab_app/core/theme/app_text_styles.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;

  const AuthTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.hint,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(18.0),
              child: prefixIcon,
            ),
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: suffixIcon,
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
          ),
        ),
      ),
    );
  }
}
