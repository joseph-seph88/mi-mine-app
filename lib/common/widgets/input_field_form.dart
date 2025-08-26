import 'package:flutter/material.dart';

class InputFieldForm extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? contentPadding;

  const InputFieldForm({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.errorText,
    this.onChanged,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon != null
            ? (onSuffixIconPressed != null
                ? IconButton(
                    icon: suffixIcon!,
                    onPressed: onSuffixIconPressed,
                  )
                : suffixIcon)
            : null,
        errorText: errorText,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
