import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/route/my_route.dart';
import 'package:flutter_app/route/route_mixin.dart';
import 'package:flutter_app/route/route_name.dart';

@ARoute(url: RouteName.page2)
class Page2 extends StatelessWidget with RouteMixin {
  final MyRouteOption option;

  Page2(this.option) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("page2"),
          ),
          onTap: () {
//            Navigator.of(context).pushAndRemoveUntil(
//              MaterialPageRoute(
//                  builder: (BuildContext context) => AppRouter.getPage(RouteName.page3, {"key2": "test2"})),
//              ModalRoute.withName(RouteName.page1),
//            );

//            Navigator.of(context).popUntil(ModalRoute.withName("/"));

            pushPage(RouteName.page3, context, blocQuery: {"key1": "test1"});

//            Navigator.of(context).push(
//              MaterialPageRoute(
//                settings: RouteSettings(name: RouteName.page3),
//                builder: (BuildContext context) => AppRouter.getPage(
//                  RouteName.page3,
//                  {"key3": "test3"},
//                ),
//              ),
//            );
          },
        ),
      ),
    );
  }
}
