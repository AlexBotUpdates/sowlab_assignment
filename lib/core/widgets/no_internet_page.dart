import 'package:flutter/material.dart';
import 'package:sowlab_app/core/widgets/custom_widgets.dart';

class NoInternetPage extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetPage({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
            const SizedBox(height: 24),
            const Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Please check your settings and try again.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: "Retry",
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
