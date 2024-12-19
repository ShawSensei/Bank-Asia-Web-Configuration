import 'package:flutter/material.dart';

import 'custom_text.dart';

class DetailInfoRowItem extends StatelessWidget {

  final String? label, value;
  final bool? showDot;
  final Color? textColors;

  const DetailInfoRowItem({super.key, required this.label,
    required this.value,
    this.showDot = false,
    this.textColors = Colors.black87});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomText(
            text: label??"",
            color: textColors,
          ),
        ),

        if(showDot == true)
           CustomText(
            text: ":",
            color: textColors,
          ),

        Expanded(
            child: CustomText(
              text: value??"",
              color: textColors,
              textAlign: TextAlign.end,
            )
        ),
      ],
    );
  }
}
