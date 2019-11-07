import 'dart:math';

import 'package:flutter/material.dart';

class TransformWidget extends StatefulWidget {
  @override
  _TransformWidgetState createState() => _TransformWidgetState();
}

class _TransformWidgetState extends State<TransformWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3));

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)..addListener(() {});

    _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, widget) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(_animation.value * pi * 2),
          child: Container(
            color: Colors.red,
            height: 200,
            width: 200,
          ),
        );
      },
    );
  }
}
