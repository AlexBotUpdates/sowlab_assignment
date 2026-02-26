import 'package:flutter/material.dart';
import 'package:sowlab_app/core/theme/app_colors.dart';

class SocialLoginButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;

  const SocialLoginButton({
    super.key,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(30),
          color: AppColors.backgroundWhite,
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}
