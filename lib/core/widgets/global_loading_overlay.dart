import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void show() {
    _isLoading = true;
    notifyListeners();
  }

  void hide() {
    _isLoading = false;
    notifyListeners();
  }
}

class GlobalLoadingOverlay extends StatelessWidget {
  final Widget child;

  const GlobalLoadingOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Consumer<LoadingProvider>(
          builder: (context, loading, _) {
            if (!loading.isLoading) return const SizedBox.shrink();
            return Container(
              color: Colors.black45,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.green),
              ),
            );
          },
        ),
      ],
    );
  }
}
