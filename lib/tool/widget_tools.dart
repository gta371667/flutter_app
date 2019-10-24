import 'dart:async';

import 'package:flutter/material.dart';

Future<Rect> getWidgetRect(BuildContext context) {
  Rect rect = Rect.zero;

  return Future.microtask(() {
    var renderObject = context.findRenderObject();
    if (renderObject != null) {
      rect = renderObject.paintBounds;
    }
    return rect;
  });
}
