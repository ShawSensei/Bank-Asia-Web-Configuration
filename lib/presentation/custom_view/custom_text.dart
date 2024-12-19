
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  final String text;
  final bool isBold;
  final Color? color;
  final double? fontSize;
  final TextAlign textAlign;

  const CustomText({super.key,
    required this.text,
    this.isBold = false,
    this.color,
    this.fontSize,
    this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        textAlign: textAlign,
        style: TextStyles.commonTextStyle.copyWith(
            fontWeight: isBold? FontWeight.bold: FontWeight.normal,
            color:  color,
            fontSize: fontSize
        )
    );
  }
}

class TextStyles {
  static const TextStyle commonTextStyle = TextStyle(
    fontSize: 14.0,
    color: Colors.black87,
  );
}
