import 'package:flutter/material.dart';

sealed class CustomButtonContent {
  const factory CustomButtonContent.text(String text) =
      TextCustomButtonContent._;

  const factory CustomButtonContent.loading() = LoadingCustomButtonContent._;

  bool get _isLoading => this is LoadingCustomButtonContent;

  const CustomButtonContent._();
}

class TextCustomButtonContent extends CustomButtonContent {
  final String text;

  const TextCustomButtonContent._(this.text) : super._();
}

class LoadingCustomButtonContent extends CustomButtonContent {
  const LoadingCustomButtonContent._() : super._();
}

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final CustomButtonContent content;

  const CustomButton({super.key, this.onPressed, required this.content});

  @override
  Widget build(BuildContext context) {
    final child = switch (content) {
      TextCustomButtonContent(text: final t) => Text(t),
      LoadingCustomButtonContent() => CircularProgressIndicator(),
    };
    return ElevatedButton(
      onPressed: content._isLoading ? null : onPressed,
      child: child,
    );
  }
}
