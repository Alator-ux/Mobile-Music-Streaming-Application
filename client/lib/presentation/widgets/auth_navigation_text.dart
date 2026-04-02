import 'package:flutter/material.dart';

class AuthNavigationText extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onPressed;

  const AuthNavigationText({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text.rich(
        TextSpan(
          text: questionText,
          children: [TextSpan(text: actionText)],
        ),
      ),
    );
  }
}
