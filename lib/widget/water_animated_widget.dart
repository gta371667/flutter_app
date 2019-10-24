import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/tool/widget_tools.dart';

/// 入場動畫元件
class EnterAnimationWidget extends StatefulWidget {
  final Widget child;

  /// 縮放係數
  final double scale;

  /// 透明係數
  final double opacity;

  /// 旋轉係數
  final double rotate;

  /// 滑動方向
  final AxisDirection direction;

  /// 動畫插值器
  final Curve curve;

  /// 時間
  final Duration duration;

  /// 若此元件會放在重複使用的列表 (List / Grid / Sliver) 裡面, 則帶入 true
  /// <p>具體說明</p>
  /// 在此元素樹生命週期內, 是否有多個 AnimationController
  /// 此參數影響到使用動畫的為 [SingleTickerProviderStateMixin] 或 [TickerProviderStateMixin]
  /// 若生命週期內只有單個請使用 [SingleTickerProviderStateMixin] 效率較高
  /// 若有多個請使用 [TickerProviderStateMixin]
  final bool multipleAnimationController;

  EnterAnimationWidget({
    @required this.child,
    this.scale,
    this.opacity,
    this.rotate,
    this.direction,
    this.duration = const Duration(milliseconds: 1000),
    this.multipleAnimationController = false,
    this.curve = Curves.bounceOut,
  });

  @override
  _EnterState createState() => multipleAnimationController ? _MultipleEnterState() : _SingleEnterState();
}

abstract class _EnterState extends State<EnterAnimationWidget> implements TickerProvider {
  AnimationController _controller;

  Animation<double> _scaleAnimation;
  Tween<double> _scaleTween;

  Animation<double> _opacityAnimation;
  Tween<double> _opacityTween;

  Animation<double> _rotateAnimation;
  Tween<double> _rotateTween;

  Animation<Offset> _offsetAnimation;
  Tween<Offset> _offsetTween;

  /// 隨機方向
  AxisDirection get randomDirection {
    var index = Random().nextInt(4);
    AxisDirection direction;
    switch (index) {
      case 0:
        direction = AxisDirection.up;
        break;
      case 1:
        direction = AxisDirection.down;
        break;
      case 2:
        direction = AxisDirection.left;
        break;
      case 3:
        direction = AxisDirection.right;
        break;
    }
    return direction ?? AxisDirection.left;
  }

  @override
  void didChangeDependencies() {
    if (widget.scale != null || widget.opacity != null || widget.direction != null) {
      _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
      )..addListener(() {
          setState(() {});
        });

      var curveAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);

      if (widget.scale != null) {
        _scaleTween = Tween<double>(begin: widget.scale - 1, end: 0);
        _scaleAnimation = _scaleTween.animate(curveAnimation);
      }

      if (widget.opacity != null) {
        _opacityTween = Tween<double>(begin: widget.opacity - 1, end: 0);
        _opacityAnimation = _opacityTween.animate(curveAnimation);
      }

      if (widget.rotate != null) {
        _rotateTween = Tween<double>(begin: widget.rotate, end: 0);
        _rotateAnimation = _rotateTween.animate(curveAnimation);
      }

      if (widget.direction != null) {
        getWidgetRect(context).then((rect) {
          if (rect != null) {
            Offset beginOffset;
            switch (widget.direction) {
              case AxisDirection.up:
                beginOffset = Offset(0, -rect.height);
                break;
              case AxisDirection.right:
                beginOffset = Offset(rect.width, 0);
                break;
              case AxisDirection.down:
                beginOffset = Offset(0, rect.height);
                break;
              case AxisDirection.left:
                beginOffset = Offset(-rect.width, 0);
                break;
            }
            _offsetTween = Tween<Offset>(begin: beginOffset, end: Offset.zero);
            _offsetAnimation = _offsetTween.animate(curveAnimation);
          }
          _controller.forward();
        });
      } else {
        _controller.forward();
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var widgetChain = widget.child;

    if (_scaleAnimation != null) {
      var scale = 1 + _scaleAnimation.value;
      widgetChain = Transform.scale(
        scale: scale,
        child: widgetChain,
      );
    }
    if (_opacityAnimation != null) {
      var opacity = 1 + _opacityAnimation.value;
      widgetChain = Opacity(
        opacity: opacity,
        child: widgetChain,
      );
    }
    if (_rotateAnimation != null) {
      widgetChain = Transform.rotate(
        angle: _rotateAnimation.value,
        child: widgetChain,
      );
    }
    if (_offsetAnimation != null) {
      widgetChain = Transform.translate(
        offset: _offsetAnimation.value,
        child: widgetChain,
      );
    }

    return widgetChain;
  }
}

class _SingleEnterState extends _EnterState with SingleTickerProviderStateMixin {
  /// controller 需要在 super.dispose 之前釋放
  /// 但奇怪的是寫在 [_TapState] 也無法正常釋放, 因此放在此處
  /// 因此無法寫在 [_TapState] 的 dispose 方法內
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _MultipleEnterState extends _EnterState with TickerProviderStateMixin {
  /// 說明參考 [_SingleEnterState] 的 dispose
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
