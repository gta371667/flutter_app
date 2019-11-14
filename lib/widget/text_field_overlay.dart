import 'package:flutter/material.dart';

/// https://medium.com/saugo360/https-medium-com-saugo360-flutter-using-overlay-to-display-floating-widgets-2e6d0e8decb9
/// flutter_typeahead
class TextFieldOverlayWidget extends StatefulWidget {
  final InputDecoration decoration;

  TextFieldOverlayWidget({
    Key key,
    this.decoration,
  }) : super(key: key);

  @override
  _TextFieldOverlayWidgetState createState() => _TextFieldOverlayWidgetState();
}

class _TextFieldOverlayWidgetState extends State<TextFieldOverlayWidget> {
  final FocusNode _focusNode = FocusNode();
  OverlayEntry _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        print("TextField 取得焦點");
        _overlayEntry = buildOverlayEntry();
        Overlay.of(context).insert(_overlayEntry);
      } else {
        print("TextField 失去焦點");
        _overlayEntry?.remove();
      }
    });
  }

  OverlayEntry buildOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var offset = renderBox.localToGlobal(Offset.zero);
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy + size.height + 5.0,
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 5.0),
            child: Material(
              elevation: 4.0,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    title: Text('Syria'),
                    onTap: () {
                      print('Syria Tapped');
                      _overlayEntry?.remove();
                    },
                  ),
                  ListTile(
                    title: Text('Lebanon'),
                    onTap: () {
                      print('Lebanon Tapped');
                      _overlayEntry?.remove();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    try {
      _overlayEntry?.remove();
    } catch (e) {}
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        autofocus: true,
        focusNode: _focusNode,
        decoration: widget.decoration ?? InputDecoration(),
      ),
    );
  }
}
