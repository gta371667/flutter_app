import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/page3_bloc.dart';
import 'package:flutter_app/tool/widget_tools.dart';

class HeroDialogWidget extends StatefulWidget {
  final String heroTag;
  final Page3Bloc bloc;
  final Offset iconOffset;

  const HeroDialogWidget({
    Key key,
    @required this.heroTag,
    @required this.bloc,
    @required this.iconOffset,
  }) : super(key: key);

  @override
  _HeroDialogWidgetState createState() => _HeroDialogWidgetState();
}

class _HeroDialogWidgetState extends State<HeroDialogWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation<Offset> _offsetAnimation;
  Tween<Offset> _offsetTween;

  GlobalKey<_HeroDialogWidgetState> _containerKey = GlobalKey();

  @override
  void didChangeDependencies() async {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        setState(() {
          print("addStatusListener setState $status");
          if (status == AnimationStatus.completed) Navigator.of(context).pop();
        });
      });

    var curveAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    WidgetTools.getWidgetLocalOffset(_containerKey).then((widgetOffset) {
      if (Offset != null) {
        var toOffset = widget.iconOffset - widgetOffset - Offset(10, 10);

        _offsetTween = Tween<Offset>(begin: Offset.zero, end: toOffset);
        _offsetAnimation = _offsetTween.animate(curveAnimation);
      }
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.5,
      alignment: Alignment.center,
      child: Container(
        color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.yellow,
              child: Hero(
                key: _containerKey,
                flightShuttleBuilder: (
                  flightContext,
                  animation,
                  direction,
                  fromContext,
                  toContext,
                ) {
                  return Icon(
                    Icons.error,
                    size: 50.0,
                  );
                },
                tag: widget.heroTag,
                child: Transform.translate(
                  offset: _offsetAnimation?.value ?? Offset.zero,
                  child: Image.asset(
                    "assets/images/gbf_bi.jpg",
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
            ),
            FlatButton(
              color: Colors.yellow,
              onPressed: () {
                _controller.reset();
                _controller.forward();
              },
              child: Text("buy"),
            ),
          ],
        ),
      ),
    );
  }
}
