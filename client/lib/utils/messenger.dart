import 'package:flutter/material.dart';

class Messenger {
  static void showError(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message ?? ''), backgroundColor: Colors.redAccent),
    );
  }
}
