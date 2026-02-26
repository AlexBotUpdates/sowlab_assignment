import 'package:flutter/material.dart';

class MessageService {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showError(String message) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showSuccess(String message) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
