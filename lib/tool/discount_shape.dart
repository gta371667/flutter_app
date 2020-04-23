import 'dart:math';

import 'package:flutter/material.dart';

class DiscountShape extends ShapeBorder {
  final EdgeInsetsGeometry dimension;
  final Radius radius;
  final double lineRate;

  final int count;

  DiscountShape({
    this.dimension,
    this.radius = Radius.zero,
    this.count = 0,
    this.lineRate = 0.75,
  });

  @override
  EdgeInsetsGeometry get dimensions => dimension;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    print("getInnerPath ${rect.toString()}");
    return null;
  }

  /// 繪製最上層
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    print("getOuterPath ${rect.toString()}");
    var path = Path();
    var w = rect.width;
    var h = rect.height;
    // 球的大小
    var d = h / (1 + 2 * count);
    print("ddd ${d.toString()}");
    path.addRect(rect);

    // 左
    for (int i = 0; i < count; i++) {
      var left = -d / 2;
      var top = 0.0 + d + 2 * d * (i);
      var right = left + d;
      var bottom = top + d;
      path.addArc(Rect.fromLTRB(left, top, right, bottom), -pi / 2, pi);
    }

    // 右
    for (int i = 0; i < count; i++) {
      var left = -d / 2 + w;
      var top = 0.0 + d + 2 * d * (i);
      var right = left + d;
      var bottom = top + d;
      path.addArc(Rect.fromLTRB(left, top, right, bottom), pi / 2, pi);
    }

    // 上
    path.addArc(Rect.fromCircle(center: Offset(w * lineRate, 0), radius: 10), -pi, -pi);

    // 下
    path.addArc(Rect.fromCircle(center: Offset(w * lineRate, h), radius: 10), -pi, pi);

    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    print("paint ${rect.toString()}");
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    var d = rect.height / (1 + 2 * count);

    bool dash = true;

    _drawDashLine(
      canvas,
      Offset(lineRate * rect.width, d / 1.5),
      rect.height / 16,
      rect.height - (d * 1.6),
      paint,
    );
//    canvas.drawLine(
//      Offset(lineRate * rect.width, d / 2 + 1),
//      Offset(lineRate * rect.width, rect.height - d / 2 - 1),
//      paint,
//    );
  }

  _drawDashLine(Canvas canvas, Offset start, double count, double length, Paint paint) {
    var step = length / count / 2;
    for (int i = 0; i < count; i++) {
      var offset = start + Offset(0, 2 * step * i);
      canvas.drawLine(offset, offset + Offset(0, step), paint);
    }
  }

  @override
  ShapeBorder scale(double t) {
    print("scale ${t.toString()}");
    return null;
  }
}
