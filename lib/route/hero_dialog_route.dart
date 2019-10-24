import 'package:flutter/material.dart';

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({
    this.builder,
    bool barrierDismissible = true,
    bool opaque = false,
    String barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 300),
    RouteTransitionsBuilder transitionBuilder,
    RouteSettings settings,
  })  : _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _barrierColor = barrierColor,
        _transitionDuration = transitionDuration,
        _transitionBuilder = transitionBuilder,
        _opaque = opaque,
        super(settings: settings);

  final WidgetBuilder builder;
  final bool _barrierDismissible;
  final Color _barrierColor;
  final String _barrierLabel;
  final Duration _transitionDuration;
  final RouteTransitionsBuilder _transitionBuilder;
  final bool _opaque;

  /// 點擊空白關閉
  @override
  bool get barrierDismissible => _barrierDismissible;

  /// 出現延遲時間
  @override
  Duration get transitionDuration => _transitionDuration;

  @override
  bool get maintainState => true;

  /// 是否隱藏背景遮罩
  @override
  bool get opaque => _opaque;

  /// 背景遮罩色
  @override
  Color get barrierColor => _barrierColor;

  @override
  String get barrierLabel => _barrierLabel;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (_transitionBuilder == null) {
      return new FadeTransition(
        opacity: new CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child,
      );
    }
    return _transitionBuilder(context, animation, secondaryAnimation, child);
  }
}
