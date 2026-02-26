import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sowlab_app/features/auth/presentation/pages/onboarding_page.dart';
import 'package:sowlab_app/injection_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final storage = sl<FlutterSecureStorage>();
    final token = await storage.read(key: 'access_token');

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    if (token != null) {
      // TODO: Navigate to HomeScreen when implemented
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingPage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingPage()));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.eco, size: 64, color: Colors.green),
              ),
              const SizedBox(height: 24),
              const Text(
                "Sowlab",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
