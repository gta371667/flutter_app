import 'dart:math';

import 'package:flutter/material.dart';

class TestAnimationWidget extends StatefulWidget {
  @override
  _TestAnimationWidgetState createState() => _TestAnimationWidgetState();
}

class _TestAnimationWidgetState extends State<TestAnimationWidget> with SingleTickerProviderStateMixin {
  AlignmentGeometry _alignment1 = Alignment.topRight;

  AnimationController _controller2;

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  bool selected3 = false;

  @override
  void initState() {
    super.initState();
    _controller2 = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  void cg1() {
    setState(() {
      _alignment1 = _alignment1 == Alignment.topRight ? Alignment.bottomLeft : Alignment.topRight;
      _controller2.isAnimating ? _controller2.stop() : _controller2.repeat();
      selected3 = !selected3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cg1,
//      child: buildCg1(),
//      child: buildCg2(),
      child: buildCg3(),
//      child: buildCg4(),
    );
  }

  Widget buildCg1() {
    return Container(
      width: 150,
      height: 150,
      color: Colors.green,
      child: AnimatedAlign(
        duration: Duration(seconds: 1),
        alignment: _alignment1,
        child: Text("aaa"),
      ),
    );
  }

  Widget buildCg2() {
    return AnimatedBuilder(
      animation: _controller2,
      builder: (context, widget) {
        return Transform.rotate(
          angle: _controller2.value * 2.0 * pi,
          child: FlutterLogo(
            size: 100,
          ),
        );
      },
    );
  }

  Widget buildCg3() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      height: selected3 ? 100 : 200,
      width: selected3 ? 100 : 200,
      transform: Matrix4.rotationX(selected3 ? 1 : 0),
      child: FlutterLogo(
        size: 50,
      ),
    );
  }

  Widget buildCg4() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Text("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
            },
          ),
        ),
      ],
    );
  }
}
