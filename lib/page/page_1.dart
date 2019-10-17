import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/route/my_route.dart';
import 'package:flutter_app/route/route_mixin.dart';
import 'package:flutter_app/route/route_name.dart';

@ARoute(url: RouteName.page1)
class Page1 extends StatefulWidget {
  final MyRouteOption option;

  Page1(this.option) : super();

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> with RouteMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pop(context, result: "aasdf");
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      appBar: AppBar(),

      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("page1"),
              ),
              onTap: () {
                pushPage(RouteName.page2, context, blocQuery: {"key1": "test1"});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 100,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("test $index"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
