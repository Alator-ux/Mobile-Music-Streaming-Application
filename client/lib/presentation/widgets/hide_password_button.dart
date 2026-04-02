import 'package:flutter/material.dart';

class HidePasswordButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool value;

  const HidePasswordButton({super.key, this.onPressed, required this.value});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(value ? Icons.visibility : Icons.visibility_off),
    );
  }
}
