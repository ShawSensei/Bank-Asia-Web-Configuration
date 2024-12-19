import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/app_colors.dart';



class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.titleText,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 40,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: onBackPressed ?? () => Get.back(),
        ),
      ),
      actions: actions,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.kBluePrimary, Colors.blue],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Text(
              titleText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
      toolbarHeight: 60.0,
      backgroundColor: AppColors.kBluePrimary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
