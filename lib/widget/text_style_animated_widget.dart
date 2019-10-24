import 'package:flutter/material.dart';

class TextStyleAnimatedWidget extends ImplicitlyAnimatedWidget {
  final Widget child;
  final TextStyle style;
  final TextAlign textAlign;
  final bool softWrap;
  final TextOverflow overflow;
  final int maxLines;

  const TextStyleAnimatedWidget({
    Key key,
    @required this.child,
    @required this.style,
    this.textAlign,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    Curve curve = Curves.linear,
    @required Duration duration,
  })  : assert(style != null),
        assert(child != null),
        assert(softWrap != null),
        assert(overflow != null),
        assert(maxLines == null || maxLines > 0),
        super(key: key, curve: curve, duration: duration);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() => _TestState();
}

//AnimatedWidgetBaseState
//ImplicitlyAnimatedWidgetState
class _TestState extends AnimatedWidgetBaseState<TextStyleAnimatedWidget> {
  TextStyleTween _style;

  @override
  Widget build(BuildContext context) {
    print("TestWidget build");
    return DefaultTextStyle(
      style: _style.evaluate(animation),
      textAlign: widget.textAlign,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      maxLines: widget.maxLines,
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    print("TestWidget forEachTween");
    _style = visitor(_style, widget.style, (dynamic value) => TextStyleTween(begin: value));
  }
}
