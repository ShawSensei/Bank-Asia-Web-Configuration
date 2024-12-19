import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as math;

import '../controller/warning_controller.dart';

class WarningView extends StatelessWidget {
  WarningView({super.key});

  final WarningController c = Get.put(WarningController());

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: c.animationController,
      builder: (BuildContext context, Widget? child) {
        return Obx(
          () => CustomPaint(
            painter: _CustomPainter(color: c.color.value),
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
  double factor = 0.96;

  _CustomPainter({required this.color}) {
    _paint.strokeCap = StrokeCap.round;
    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = 4.0;
    _paint.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.addArc(Rect.fromCircle(center: Offset(_r, _r), radius: _r), 0.0, math.radians(360.0));

    double factor = 64 / 1.5;
    path.moveTo(_r, 15.0);
    path.lineTo(_r, factor);

    path.moveTo(_r, factor + 10.0);
    path.addArc(Rect.fromCircle(center: Offset(_r, factor + 10.0), radius: 1.0), 0.0, math.radians(360.0));

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(_CustomPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
