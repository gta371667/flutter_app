import 'dart:async';

import 'package:flutter/material.dart';

class WidgetTools {
  static Future<Rect> getWidgetRect(BuildContext context) {
    Rect rect = Rect.zero;

    return Future.microtask(() {
      var renderObject = context.findRenderObject();
      if (renderObject != null) {
        rect = renderObject.paintBounds;
      }
      return rect;
    });
  }

  /// 取得元件的dx dy
  static Future<Offset> getWidgetLocalOffset(GlobalKey globalKey) {
    Offset offset = Offset.zero;

    return Future.delayed(Duration(milliseconds: 100), () {
      RenderBox renderBox = globalKey.currentContext.findRenderObject();
      if (renderBox != null) {
        offset = renderBox.localToGlobal(Offset.zero);
      }
      return offset;
    });

//  return Future.microtask(() {
//    RenderBox renderBox = globalKey.currentContext.findRenderObject();
//    if (renderBox != null) {
//      offset = renderBox.localToGlobal(Offset.zero);
//    }
//    return offset;
//  });
  }

  /// 取得元件的dx dy
  static Future<Offset> testOffset(GlobalKey globalKey) async {
    Offset offset;
    var isRectGet = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox = globalKey?.currentContext?.findRenderObject();
      if (renderBox != null) {
        offset = renderBox.localToGlobal(Offset.zero);
      }
      isRectGet = true;
    });
    while (!isRectGet) {
      await Future.delayed(Duration.zero);
    }
    return offset;
  }
}
