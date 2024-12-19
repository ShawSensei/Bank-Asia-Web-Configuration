import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_colors.dart';
import '../view/error_view.dart';
import '../view/success_view.dart';
import '../view/warning_view.dart';

enum SweetAlertStyle { success, warning, error, loading }

class SweetAlertOptions {
  final SweetAlertStyle style;
  final String? title;
  final String? subtitle;
  final VoidCallback? onPrimaryButtonPressed;
  final VoidCallback? onSecondaryButtonPressed;
  final Color? primaryButtonColor;
  final Color? secondaryButtonColor;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final bool? showSecondaryButton;

  SweetAlertOptions({
    required this.style,
    this.title,
    this.subtitle,
    this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
    this.primaryButtonColor,
    this.secondaryButtonColor,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.showSecondaryButton,
  });
}

class SweetAlertController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  var options = SweetAlertOptions(style: SweetAlertStyle.loading).obs; // Observable
  var listOfChildren = <Widget>[].obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Curves.bounceOut))
      ..addListener(() {
        update(); // Update UI
      });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void updateOptions(SweetAlertOptions newOptions) {
    options.value = newOptions;
  }

  List<Widget> getChildren() {
    listOfChildren.clear();

    switch (options.value.style) {
      case SweetAlertStyle.success:
        listOfChildren.add(
          SizedBox(
            width: 64.0,
            height: 64.0,
            child: SuccessView(),
          ),
        );
        break;
      case SweetAlertStyle.warning:
        listOfChildren.add(
          SizedBox(
            width: 64.0,
            height: 64.0,
            child: WarningView(),
          ),
        );
        break;
      case SweetAlertStyle.error:
        listOfChildren.add(
          SizedBox(
            width: 64.0,
            height: 64.0,
            child: ErrorView(),
          ),
        );
        break;
      case SweetAlertStyle.loading:
        listOfChildren.add(
          const SizedBox(
            width: 64.0,
            height: 64.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
        break;
    }

    if (options.value.title != null) {
      listOfChildren.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            options.value.title!,
            style: const TextStyle(fontSize: 24.0, color: Color(0xff575757)),
          ),
        ),
      );
    }

    if (options.value.subtitle != null) {
      listOfChildren.add(
        Text(
          options.value.subtitle!,
          style: const TextStyle(color: Color(0xff797979)),
          maxLines: 12,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    // Buttons are not rendered when style is loading
    if (options.value.style != SweetAlertStyle.loading) {
      if (options.value.showSecondaryButton == true) {
        listOfChildren.add(
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: options.value.secondaryButtonColor ?? Colors.grey,
                  ),
                  onPressed: options.value.onSecondaryButtonPressed,
                  child: Text(
                    options.value.secondaryButtonText ?? 'Cancel',
                    style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: options.value.primaryButtonColor ?? AppColors.kBluePrimary,
                  ),
                  onPressed: options.value.onPrimaryButtonPressed,
                  child: Text(
                    options.value.primaryButtonText ?? 'Confirm',
                    style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        listOfChildren.add(
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: options.value.primaryButtonColor ?? AppColors.kBluePrimary,
              ),
              onPressed: options.value.onPrimaryButtonPressed,
              child: Text(
                options.value.primaryButtonText ?? 'OK',
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        );
      }
    }

    return listOfChildren;
  }
}
