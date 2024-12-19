import 'package:get/get.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class SuccessController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late SequenceAnimation sequenceAnimation;

  var strokeStart = 0.0.obs; // Observable
  var strokeEnd = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    int factor = 50;
    animationController = AnimationController(vsync: this);
    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
      animatable: Tween(begin: 0.0, end: 0.70),
      from: Duration(milliseconds: 3 * factor),
      to: Duration(milliseconds: 10 * factor),
      tag: "start",
    )
        .addAnimatable(
      animatable: Tween(begin: 0.0, end: 1.0),
      from: const Duration(milliseconds: 0),
      to: Duration(milliseconds: 10 * factor),
      tag: "end",
      curve: Curves.easeOut,
    )
        .animate(animationController);

    animationController.addListener(() {
      strokeStart.value = sequenceAnimation['start'].value;
      strokeEnd.value = sequenceAnimation['end'].value;
    });

    // Delay the start of the animation
    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      animationController.forward();
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}