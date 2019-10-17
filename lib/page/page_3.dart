import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/route/my_route.dart';
import 'package:flutter_app/route/route_mixin.dart';
import 'package:flutter_app/route/route_name.dart';

@ARoute(url: RouteName.page3)
class Page3 extends StatelessWidget with RouteMixin {
  final MyRouteOption option;

  Page3(this.option) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("page3"),
          ),
          onTap: () {
//            Navigator.of(context).pushAndRemoveUntil(
//              MaterialPageRoute(
//                  builder: (BuildContext context) => AppRouter.getPage(RouteName.page1, {"key2": "test2"})),
//              ModalRoute.withName(RouteName.page1),
//            );

//            pushPage(RouteName.page1, context, pushAndRemoveUntil: (v) => v == "/");

            pop(context, popUntil: (v) => v == "/");

//            Navigator.of(context).push(
//              MaterialPageRoute(
//                builder: (BuildContext context) => AppRouter.getPage(
//                  RouteName.page1,
//                  {"key2": "test2"},
//                ),
//              ),
//            );
          },
        ),
      ),
    );
  }
}
