import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/painter.dart';

class SemiCircleWidget extends StatelessWidget {
  final double? diameter;
  final double? sweepAngle;
  final Color? color;

  const SemiCircleWidget({
    Key? key,
    this.diameter = 200,
    @required this.sweepAngle,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(sweepAngle, color),
      size: Size(diameter!, diameter!),
    );
  }
}
