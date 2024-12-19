import 'package:flutter/material.dart';

import 'custom_dialog.dart';

class CustomAppbarAction extends StatelessWidget {
  final String dialogHeader;
  final List<InlineSpan> dialogContent;

  const CustomAppbarAction({
    super.key,
    required this.dialogHeader,
    required this.dialogContent,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SizedBox(
        width: 25.0,
        child: Image.asset('assets/icon_help.png'),
      ),
      onPressed: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomDialog.showInfoDialog(dialogHeader, dialogContent);
        });
      },
    );
  }
}
