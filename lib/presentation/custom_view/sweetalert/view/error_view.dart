import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as math;

import '../controller/error_controller.dart';

class ErrorView extends StatelessWidget {
  ErrorView({super.key});

  final ErrorController c = Get.put(ErrorController());

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: c.animationController,
      builder: (BuildContext context, Widget? child) {
        return Obx(
          () => Transform(
            transform: Matrix4.rotationX(math.radians(c.rotation.value)),
            origin: const Offset(0.0, 32.0),
            child: CustomPaint(
              painter: _CustomPainter(
                color: Colors.red[700]!,
                fade: c.fade.value,
                factor: c.factor.value,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CustomPainter extends CustomPainter {
  final Paint _paint = Paint();
  final Color color;
  final double _r = 32.0;
  final double fade;
  final double factor;

  _CustomPainter({required this.color, required this.fade, required this.factor}) {
    _paint.strokeCap = StrokeCap.round;
    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = 4.0;
    _paint.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    _paint.color = color;

    // Draw the circle
    path.addArc(Rect.fromCircle(center: Offset(_r, _r), radius: _r), 0.0, math.radians(360.0));
    canvas.drawPath(path, _paint);

    path = Path();
    // Fade the color
    _paint.color = Color(color.value & 0x00FFFFFF + ((0xff * fade).toInt() << 24));

    // Draw the cross
    path.moveTo(_r - factor, _r - factor);
    path.lineTo(_r + factor, _r + factor);

    path.moveTo(_r + factor, _r - factor);
    path.lineTo(_r - factor, _r + factor);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(_CustomPainter oldDelegate) {
    return color != oldDelegate.color || fade != oldDelegate.fade;
  }
}
