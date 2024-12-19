import 'package:flutter/material.dart';

import '../../common/app_colors.dart';



class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double? buttonTextSize;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final RoundedRectangleBorder? shape;
  final IconData? icon;
  final Color? iconColor;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.buttonTextSize,
    this.padding,
    this.color,
    this.shape,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        backgroundColor: color ?? AppColors.kBluePrimary,
        shape: shape,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor ?? Colors.white),
            const SizedBox(width: 8.0),
          ],
          Text(
            buttonText,
            style: TextStyle(color: Colors.white, fontSize: buttonTextSize),
          ),
        ],
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double? buttonTextSize;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final RoundedRectangleBorder? shape;
  final IconData? icon;
  final Color? iconColor;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.buttonTextSize,
    this.padding,
    this.color,
    this.shape,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: padding,
        backgroundColor: color ?? Colors.white,
        shape: shape,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor ?? Colors.black),
            const SizedBox(width: 8.0),
          ],
          Text(
            buttonText,
            style: TextStyle(color: Colors.black, fontSize: buttonTextSize),
          ),
        ],
      ),
    );
  }
}
