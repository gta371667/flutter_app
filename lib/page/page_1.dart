import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/route/hero.dart';
import 'package:flutter_app/route/hero_dialog_route.dart';
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
  AlignmentGeometry _alignment = Alignment.topRight;

  void _changeAlignment() {
    setState(() {
      _alignment = _alignment == Alignment.topRight ? Alignment.bottomLeft : Alignment.topRight;
    });
  }

  @override
  void initState() {
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
          _changeAlignment();

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
          Hero(
            tag: HeroTag.flutterLogo,
            child: FlutterLogo(
              size: 300,
            ),
          ),
          TestAnimationWidget(),
          buildCg4(),
//          Expanded(
//            child: CustomScrollView(
//              slivers: <Widget>[
//                buildSliverAppBar(),
////                buildSliverGrid(),
////                SliverPersistentHeader(
////                  pinned: true,
////                  floating: true,
////                  delegate: SliverAppBarDelegate(
////                    minHeight: 0.0,
////                    floating: true,
////                    pinned: true,
////                    maxHeight: 180.0,
////                    child: Container(
////                      child: Image.asset(
////                        "assets/images/bg_login.png",
////                        fit: BoxFit.fill,
////                      ),
////                    ),
////                  ),
////                ),
//                SliverFillViewport(
//                  viewportFraction: 1,
//                  delegate: SliverChildListDelegate(
//                    [
//                      Container(
//                        child: Text("aaaa"),
//                        color: Colors.red,
//                        alignment: Alignment.center,
//                      ),
//                      Container(
//                        child: Text("aaaa"),
//                        color: Colors.yellow,
//                        alignment: Alignment.center,
//                      ),
//                      Container(
//                        child: Text("aaaa"),
//                        color: Colors.red,
//                        alignment: Alignment.center,
//                      ),
//                      Container(
//                        child: Text("aaaa"),
//                        color: Colors.yellow,
//                        alignment: Alignment.center,
//                      ),
//                      Container(
//                        child: Text("aaaa"),
//                        color: Colors.red,
//                        alignment: Alignment.center,
//                      ),
//                    ],
//                  ),
//                ),
////                SliverFillRemaining(
////                  fillOverscroll: false,
////                  hasScrollBody: true,
////                  child: Text("aaaa"),
////                )
//              ],
//            ),
//          ),
        ],
      ),
    );
  }

  SliverGrid buildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          StatefulBuilder(builder: (c, state) {
            return Text("aa");
          });
          showDialog(context: null);

          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Text("test $index"),
          );
        },
        childCount: 100,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    );
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      title: Text("title"),
      expandedHeight: 150,
      backgroundColor: Colors.yellow,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(color: Colors.red),
        title: Container(
          color: Colors.black,
          child: Text("FlexibleSpaceBar"),
        ),
        centerTitle: true,
      ),
      forceElevated: true,
//      snap: true,
//      floating: true,
      pinned: true,
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
