import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WarningController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Color?> animation;

  var color = Colors.transparent.obs; // Observable

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(vsync: this);
    animation = ColorTween(begin: const Color(0xffF7D58B), end: const Color(0xffF2A665)).animate(animationController);

    animation.addListener(() {
      color.value = animation.value!;
    });

    // Delay the start of the animation
    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      forward();
    });
  }

  void forward() {
    animationController.animateTo(1.0, duration: const Duration(milliseconds: 600), curve: Curves.ease).then((_) {
      backward();
    });
  }

  void backward() {
    animationController.animateTo(0.0, duration: const Duration(milliseconds: 600), curve: Curves.ease).then((_) {
      forward();
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
