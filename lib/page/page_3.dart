import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/page3_bloc.dart';
import 'package:flutter_app/route/bloc_provider.dart';
import 'package:flutter_app/route/hero_dialog_route.dart';
import 'package:flutter_app/route/hero_tag.dart';
import 'package:flutter_app/route/my_route.dart';
import 'package:flutter_app/route/route_mixin.dart';
import 'package:flutter_app/route/route_name.dart';
import 'package:flutter_app/widget/hero_dialog_widget.dart';
import 'package:flutter_app/widget/sliver_appBar_delegate.dart';

@ARoute(url: RouteName.page3)
class Page3 extends StatefulWidget {
  final MyRouteOption option;

  Page3(this.option) : super();

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> with RouteMixin {
  Page3Bloc bloc;

  GlobalKey<_Page3State> _containerKey = GlobalKey();
  Offset iconOffset = Offset.zero;

  @override
  void initState() {
    bloc = BlocProvider.of<Page3Bloc>(context);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((a) {
      RenderBox renderBox = _containerKey.currentContext?.findRenderObject();
      if (renderBox != null) {
        iconOffset = renderBox.localToGlobal(Offset.zero);
        print("iconOffset ${iconOffset.toString()}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pop(context, popUntil: (v) => v == "/");
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
//          buildSliverAppBar(),
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: SliverAppBarDelegate(
              minHeight: 0.0,
              floating: true,
              pinned: true,
              maxHeight: 180.0,
              child: Container(
                child: Image.asset(
                  "assets/images/bg_login.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          buildSliverGrid(),
        ],
      ),
    );
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      title: Text("title"),
      actions: <Widget>[
        Hero(
          tag: HeroTag.favorite,
          child: Container(
            key: _containerKey,
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                print("6666666666666");
              },
            ),
          ),
        ),
      ],
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
      snap: true,
      floating: true,
      pinned: true,
    );
  }

  SliverGrid buildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          StatefulBuilder(builder: (c, state) {
            return Text("aa");
          });
          return InkWell(
            onTap: () {
              bloc.setHeroTag("${HeroTag.flutterLogo}$index");

              var a = ModalRoute.of(context);
              var b = ModalRoute.of(context);

//              Navigator.push(
//                context,
//                new HeroDialogRoute(
//                  builder: (BuildContext context) => HeroDialogWidget(
//                    bloc: bloc,
//                    heroTag: "${HeroTag.flutterLogo}$index",
//                    iconOffset: iconOffset,
//                  ),
//                ),
//              );
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                flightShuttleBuilder: (
                  flightContext,
                  animation,
                  direction,
                  fromContext,
                  toContext,
                ) {
                  return Icon(
                    Icons.code,
                    size: 50.0,
                  );
                },
                transitionOnUserGestures: true,
                placeholderBuilder: (context, size, widget) {
                  return Container(
                    color: Colors.deepOrange,
                    child: widget,
                  );
                },
                tag: "${HeroTag.flutterLogo}$index",
                child: FlutterLogo(
                  size: 50,
                ),
              ),
            ),
          );
        },
        childCount: 100,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    );
  }
}
