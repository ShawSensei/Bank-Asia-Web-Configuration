import 'package:flutter/material.dart';

class CustomRectangle extends StatelessWidget {
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Widget child;

  const CustomRectangle({
    super.key,
    this.onPressed,
    this.padding,
    this.margin,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: margin ?? const EdgeInsets.all(2.0),
        padding: padding ?? const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
