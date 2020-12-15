import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class Hill extends StatefulWidget {

  final double height;
  final double width;
  final Color color;
  final double velocity;
  final int total;

  Hill(this.height, this.width, this.color, this.velocity, this.total, {Key key,}) : super(key: key);

  @override
  _HillState createState() => _HillState(height, width, color, velocity, total);
}

class _HillState extends State<Hill> {

  final double height;
  final double width;
  final Color color;
  final double velocity;
  final int total;
  final List<Offset> points = [];

  _HillState(this.height, this.width, this.color, this.velocity, this.total);

  @override
  void initState() {
    var size = Size(width, 500);

    final num gap = (size.width / (total - 2)).ceil();

    for (int i = 0; i < total; i++) {
      points.add(Offset(i * gap, getHillY(size)));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      child: LoopAnimation<double>(
        duration: Duration(seconds: 5),
        tween: Tween()..begin = 0.0..end = 2,
        builder: (context, child, value) {
          return CustomPaint(
            foregroundPainter: HillPainter(color, velocity, total, points),
          );
        },
      ),
    );
  }
}

class HillPainter extends CustomPainter {

  final Color color;
  final double velocity;
  final int total;
  final List<Offset> points;

  HillPainter(this.color, this.velocity, this.total, this.points);

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var paint = Paint()
      ..color = color;

    points[0] = points[0].translate(velocity, 0);
    var cur = points[0];
    var prev = cur;
    var cx, cy;

    final num gap = (size.width / (total - 2)).ceil();

    if (cur.dx > -gap) {
      points.insert(0, Offset(-gap*2, getHillY(size)));
    } else if (cur.dx > size.width + gap) {
      points.removeLast();
    }

    path.moveTo(cur.dx, cur.dy);

    var prevCx = cur.dx;
    var prevCy = cur.dy;

    for (int i = 1; i < points.length; i++) {
      points[i] = points[i].translate(velocity, 0);
      cur = points[i];

      cx = (prev.dx + cur.dx) / 2;
      cy = (prev.dy + cur.dy) / 2;

      path.quadraticBezierTo(prev.dx, prev.dy, cx, cy);

      prevCx = cx;
      prevCy = cy;

      prev = cur;
    }

    path.lineTo(prev.dx, prev.dy);
    path.lineTo(points.last.dx, size.height);
    path.lineTo(points[0].dx, size.height);
    path.lineTo(points[0].dx, points[0].dy);


    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

double getHillY(Size size) {
  double min = size.height / 8;
  double max = size.height - min;
  final random = Random();
  return min + random.nextInt((max - min).toInt());
}