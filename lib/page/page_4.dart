import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/page4_bloc.dart';
import 'package:flutter_app/route/bloc_provider.dart';
import 'package:flutter_app/route/my_route.dart';
import 'package:flutter_app/route/route_mixin.dart';
import 'package:flutter_app/route/route_name.dart';
import 'package:flutter_app/widget/text_field_overlay.dart';

@ARoute(url: RouteName.page4)
class Page4 extends StatefulWidget {
  final MyRouteOption option;

  Page4(this.option) : super();

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page4> with RouteMixin {
  Page4Bloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<Page4Bloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Page4"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            pop(context, popUntil: (v) => v == "/");
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            TextFieldOverlayWidget(
              decoration: InputDecoration(hintText: "text1",hintStyle: TextStyle()),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextFieldOverlayWidget(
                decoration: InputDecoration(hintText: "text2"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextFieldOverlayWidget(
                decoration: InputDecoration(hintText: "text3"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextFieldOverlayWidget(
                decoration: InputDecoration(hintText: "text4"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextFieldOverlayWidget(
                decoration: InputDecoration(hintText: "text5"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextFieldOverlayWidget(
                decoration: InputDecoration(hintText: "text6"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextFieldOverlayWidget(
                decoration: InputDecoration(hintText: "text7"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextFieldOverlayWidget(
                decoration: InputDecoration(hintText: "text8"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextFieldOverlayWidget(
                decoration: InputDecoration(hintText: "text9"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextFieldOverlayWidget(
                decoration: InputDecoration(hintText: "text10"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextFieldOverlayWidget(
                decoration: InputDecoration(hintText: "text11"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextFieldOverlayWidget(
                decoration: InputDecoration(hintText: "text12"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: TextFieldOverlayWidget(
                decoration: InputDecoration(hintText: "text13"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
