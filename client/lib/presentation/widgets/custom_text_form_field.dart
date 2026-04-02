import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String labelText;
  final Widget? suffixIcon;
  final bool? isPasswordField;

  const CustomTextFormField({
    required this.labelText,
    this.controller,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.isPasswordField,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPasswordField ?? false,
      onChanged: onChanged,
      autovalidateMode: .onUserInteractionIfError,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
