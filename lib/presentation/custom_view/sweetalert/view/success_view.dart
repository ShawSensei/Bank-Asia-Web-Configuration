import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as math;

import '../controller/success_controller.dart';

class SuccessView extends StatelessWidget {
  SuccessView({super.key});

  final SuccessController c = Get.put(SuccessController());

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: c.animationController,
      builder: (BuildContext context, Widget? child) {
        return Obx(
          () => CustomPaint(
            painter: _CustomPainter(
              strokeStart: c.strokeStart.value,
              strokeEnd: c.strokeEnd.value,
            ),
          ),
        );
      },
    );
  }
}

class _CustomPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double _r = 32.0;
  double factor = 0.96;

  final double strokeStart;
  final double strokeEnd;
  double total = 0;

  late double _strokeStart;
  late double _strokeEnd;

  _CustomPainter({required this.strokeEnd, required this.strokeStart}) {
    _paint.strokeCap = StrokeCap.round;
    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = 4.0;

    Path path = createPath();
    PathMetrics metrics = path.computeMetrics();
    for (PathMetric pathMetric in metrics) {
      total += pathMetric.length;
    }

    _strokeStart = strokeStart * total;
    _strokeEnd = strokeEnd * total;
  }

  Path createPath() {
    Path path = Path();
    path.addArc(Rect.fromCircle(center: Offset(_r, _r), radius: _r), math.radians(60.0 - 30.0), math.radians(-200.0));
    path.lineTo(24.0, 46.0);
    path.lineTo(49.0, 18.0);
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.addArc(Rect.fromCircle(center: Offset(_r, _r), radius: _r), 0.0, math.radians(360.0));
    _paint.color = const Color(0x4096d873);
    canvas.drawPath(path, _paint);

    _paint.color = const Color(0xff96d873);
    path = createPath();
    PathMetrics metrics = path.computeMetrics();
    for (PathMetric pathMetric in metrics) {
      canvas.drawPath(pathMetric.extractPath(_strokeStart, _strokeEnd), _paint);
    }
  }

  @override
  bool shouldRepaint(_CustomPainter oldDelegate) {
    return strokeStart != oldDelegate.strokeStart || strokeEnd != oldDelegate.strokeEnd;
  }
}
