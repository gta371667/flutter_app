import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/page1_bloc.dart';
import 'package:flutter_app/route/bloc_provider.dart';
import 'package:flutter_app/route/hero_dialog_route.dart';
import 'package:flutter_app/route/hero_tag.dart';
import 'package:flutter_app/route/my_route.dart';
import 'package:flutter_app/route/route_mixin.dart';
import 'package:flutter_app/route/route_name.dart';
import 'package:flutter_app/widget/test_animation.dart';
import 'package:flutter_app/widget/water_animated_widget.dart';

@ARoute(url: RouteName.page1)
class Page1 extends StatefulWidget {
  final MyRouteOption option;

  Page1(this.option) : super();

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> with RouteMixin {
  Page1Bloc bloc;
  AnimationController testCallBackController;

  @override
  void initState() {
    bloc = BlocProvider.of<Page1Bloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(),
      drawerScrimColor: Colors.yellow,
      drawerEdgeDragWidth: 100,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            new HeroDialogRoute(
              builder: (BuildContext context) {
                return FractionallySizedBox(
                  widthFactor: 0.8,
                  heightFactor: 0.3,
                  alignment: Alignment.center,
                  child: Container(
                    color: Colors.yellow,
                    child: Hero(
                      tag: HeroTag.flutterLogo,
                      child: FlutterLogo(
                        size: 100,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("aa"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("page1"),
                  ),
                  onTap: () {
                    pushPage(RouteName.page2, context, blocQuery: {"key1": "test1"});
                  },
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("page4"),
                  ),
                  onTap: () {
                    pushPage(RouteName.page4, context, blocQuery: {"key1": "test1"});
                  },
                ),
              ],
            ),
          ),
//          TransformWidget(),
//          GestureDetector(
//            onScaleUpdate: (details) {
//              print("onScaleUpdate ${details.toString()}");
//              setState(() {
//                //缩放倍数在0.8到10倍之间
//                _width = 200 * details.scale.clamp(.8, 2.0);
//              });
//            },
//            child: Image.asset(
//              "assets/images/gbf_bi.jpg",
//              height: _width,
//              width: _width,
//              fit: BoxFit.fill,
//            ),
//          ),
          TestAnimationWidget(),
          buildCg4(),
        ],
      ),
    );
  }

  Widget buildDrawer() {
    return Container(
      color: Colors.blue,
      width: 200,
    );
  }

  Widget buildCg4() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return EnterAnimationWidget(
            multipleAnimationController: true,
            direction: AxisDirection.left,
            curve: Curves.easeOut,
            duration: Duration(milliseconds: 1000),
            child: Container(
              margin: EdgeInsets.all(10),
              color: Colors.blueAccent,
              child: Text("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"),
            ),
          );
        },
      ),
    );
  }
}
