import 'package:flutter/material.dart';

typedef TestCallBack = void Function(AnimationController animationController);

class GrowTransition extends StatefulWidget {
  GrowTransition({this.child, this.testCallBack});

  final Widget child;
  final TestCallBack testCallBack;

  @override
  _GrowTransitionState createState() => _GrowTransitionState();
}

class _GrowTransitionState extends State<GrowTransition> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 50, end: 200).animate(_controller);

    if (widget.testCallBack != null) {
      widget.testCallBack(_controller);
    }

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget child) {
          return new Container(
            height: _animation.value,
            width: _animation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
