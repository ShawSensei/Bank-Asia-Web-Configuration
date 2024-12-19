import 'package:get/get.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class ErrorController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late SequenceAnimation sequenceAnimation;

  var rotation = 0.0.obs; // Observable
  var fade = 0.0.obs;
  var factor = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(vsync: this);
    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
          animatable: Tween(begin: 90.0, end: 0.0),
          from: const Duration(milliseconds: 0),
          to: const Duration(milliseconds: 300),
          tag: "rotation",
        )
        .addAnimatable(
          animatable: Tween(begin: 0.3, end: 1.0),
          from: const Duration(milliseconds: 600),
          to: const Duration(milliseconds: 900),
          tag: "fade",
          curve: Curves.bounceOut,
        )
        .addAnimatable(
          animatable: Tween(begin: 32.0 / 5.0, end: 32.0 / 2.0),
          from: const Duration(milliseconds: 600),
          to: const Duration(milliseconds: 900),
          tag: "fact",
          curve: Curves.bounceOut,
        )
        .animate(animationController);

    animationController.addListener(() {
      rotation.value = sequenceAnimation['rotation'].value;
      fade.value = sequenceAnimation['fade'].value;
      factor.value = sequenceAnimation['fact'].value;
    });

    // Delay the start of the animation
    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      forward();
    });
  }

  void forward() {
    animationController.animateTo(1.0, duration: const Duration(milliseconds: 600), curve: Curves.ease).then((_) {});
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
