import 'package:flutter/material.dart';
import 'package:sowlab_app/core/theme/app_colors.dart';
import 'package:sowlab_app/core/theme/app_text_styles.dart';
import 'package:sowlab_app/core/theme/app_radius.dart';
import 'package:sowlab_app/features/auth/presentation/widgets/onboarding/onboarding_indicator.dart';
import 'package:sowlab_app/features/auth/presentation/widgets/onboarding/onboarding_button.dart';
import 'package:sowlab_app/features/auth/presentation/pages/login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: "Quality",
      description:
          "Sell your farm fresh products directly to consumers, cutting out the middleman and reducing emissions of the global supply chain.",
      image: "assets/illustrations/Group 44.png",
      backgroundColor: AppColors.onboardingGreen,
    ),
    OnboardingData(
      title: "Convenient",
      description:
          "Our team of delivery drivers will make sure your orders are picked up on time and promptly delivered to your customers.",
      image: "assets/illustrations/Group.png",
      backgroundColor: AppColors.onboardingTerracotta,
    ),
    OnboardingData(
      title: "Local",
      description:
          "We love the earth and know you do too! Join us in reducing our local carbon footprint one order at a time.",
      image: "assets/illustrations/Group 46.png",
      backgroundColor: AppColors.onboardingAmber,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: _onboardingData[_currentIndex].backgroundColor,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Image.asset(
                          _onboardingData[index].image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppRadius.onboardingContainerRadius),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 40,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _onboardingData[_currentIndex].title,
                      style: AppTextStyles.title,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _onboardingData[_currentIndex].description,
                      style: AppTextStyles.subtitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    OnboardingIndicator(
                      count: _onboardingData.length,
                      currentIndex: _currentIndex,
                    ),
                    const SizedBox(height: 48),
                    OnboardingButton(
                      text: "Join the movement!",
                      color: _onboardingData[_currentIndex].backgroundColor,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      child: Text(
                        "Login",
                        style: AppTextStyles.linkText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String image;
  final Color backgroundColor;

  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundColor,
  });
}
