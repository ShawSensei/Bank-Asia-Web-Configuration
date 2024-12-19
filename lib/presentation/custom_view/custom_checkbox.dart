
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final Widget text;
  final ValueChanged<bool?>? onChanged;

  const CustomCheckbox({
    super.key,
    required this.isChecked,
    required this.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
          checkColor: Colors.white, // Color of the check mark
          activeColor: Colors.blue[900], // Color of the checkbox
        ),
        Expanded(
            child: text
        ),
      ],
    );
  }
}

