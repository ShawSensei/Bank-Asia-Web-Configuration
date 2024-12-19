import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final bool obscureText;
  final bool isAbsorbing;

  const CustomTextFromField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.textStyle,
    this.contentPadding,
    this.margin,
    this.obscureText = false,
    this.isAbsorbing = false,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isAbsorbing,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: const TextStyle(
            fontSize: 14.0,
          ),
          hintStyle: const TextStyle(
            fontSize: 14.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          contentPadding: contentPadding ?? const EdgeInsets.all(16.0),
        ),
        style: textStyle ??
            const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
      ),
    );
  }
}

class CustomTextFieldBinimoy extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final bool obscureText;
  final bool isAbsorbing;

  const CustomTextFieldBinimoy({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.textStyle,
    this.contentPadding,
    this.margin,
    this.obscureText = false,
    this.isAbsorbing = false,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isAbsorbing,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: const TextStyle(
            fontSize: 14.0,
          ),
          hintStyle: const TextStyle(
            fontSize: 14.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          contentPadding: contentPadding ?? const EdgeInsets.all(16.0),
          suffixText: '@binimoy',
          // Adding the @binimoy text at the end of the field
          suffixStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        style: textStyle ??
            const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
      ),
    );
  }
}
