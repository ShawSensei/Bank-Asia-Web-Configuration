import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/sweetalert_controller.dart';

class SweetAlertDialog extends StatelessWidget {
  final SweetAlertOptions options;

  SweetAlertDialog({super.key, required this.options});

  final SweetAlertController c = Get.put(SweetAlertController());

  @override
  Widget build(BuildContext context) {
    // Use WidgetsBinding to defer the forward call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.updateOptions(options);
      c.animationController.forward(from: 0.0); // Restart animation
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AnimatedBuilder(
          animation: c.animationController,
          builder: (BuildContext context, Widget? child) {
            return ScaleTransition(
              scale: c.animation,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: c.getChildren(),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
