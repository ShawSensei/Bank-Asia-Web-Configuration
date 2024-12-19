import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import 'sweetalert/view/sweetalert_dialog.dart';
import 'sweetalert/controller/sweetalert_controller.dart';

class CustomDialog {
  static void showSuccess(String message, {String? title}) {
    Get.dialog(
      SweetAlertDialog(
        options: SweetAlertOptions(
          style: SweetAlertStyle.success,
          title: title ?? 'Success',
          subtitle: message,
          onPrimaryButtonPressed: () => Get.back(),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }

  static void showWarning(String message, {String? title}) {
    Get.dialog(
      SweetAlertDialog(
        options: SweetAlertOptions(
          style: SweetAlertStyle.warning,
          title: title ?? 'Warning',
          subtitle: message,
          onPrimaryButtonPressed: () => Get.back(),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }

  static void showLogout(String message, {String? title}) {
    Get.dialog(
      PopScope(
        canPop: false,
        child: SweetAlertDialog(
          options: SweetAlertOptions(
            style: SweetAlertStyle.warning,
            title: title ?? 'Attention',
            subtitle: message,
            onPrimaryButtonPressed: () {
              Get.back();
              // Get.until((route) => route.settings.name == '/BlankScreen');
              // channel.invokeMethod('navigateToNativeLogin');
            },
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }

  static void showError(String message, {String? title}) {
    Get.dialog(
      SweetAlertDialog(
        options: SweetAlertOptions(
          style: SweetAlertStyle.error,
          title: title ?? 'Error',
          subtitle: message,
          onPrimaryButtonPressed: () => Get.back(),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }

  static void showLoadingDialog({String? subtitle}) {
      Get.dialog(
        SweetAlertDialog(
          options: SweetAlertOptions(
            style: SweetAlertStyle.loading,
            subtitle: subtitle ?? 'Please wait...',
          ),
        ),
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.3),
      );

  }

  static void showAsking(
    String message, {
    String? title,
    VoidCallback? onPrimaryButtonPressed,
    VoidCallback? onSecondaryButtonPressed,
  }) {
    Get.dialog(
      SweetAlertDialog(
        options: SweetAlertOptions(
          style: SweetAlertStyle.warning,
          title: title ?? 'Attention',
          subtitle: message,
          onPrimaryButtonPressed: onPrimaryButtonPressed,
          onSecondaryButtonPressed: onSecondaryButtonPressed,
          showSecondaryButton: true,
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }

  static void showInfoDialog(String title, List<InlineSpan> info) {
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(10.0),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: SizedBox(
                          height: 30.0,
                          child: Image.asset('assets/icon_close.png'),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(text: TextSpan(children: info)),
                    ],
                  ),
                  const Divider(),
                  const Text(
                    'For more assistance, please call 16205 or 09617016205',
                    style: TextStyle(fontSize: 10.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }
}
