import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/page2_bloc.dart';
import 'package:flutter_app/route/bloc_provider.dart';
import 'package:flutter_app/route/my_route.dart';
import 'package:flutter_app/route/route_mixin.dart';
import 'package:flutter_app/route/route_name.dart';
import 'package:flutter_app/widget/text_style_animated_widget.dart';

@ARoute(url: RouteName.page2)
class Page2 extends StatefulWidget {
  final MyRouteOption option;

  Page2(this.option) : super();

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> with RouteMixin {
  Page2Bloc bloc;
  int currentIndex = 0;

  List<Step> steps = [
    Step(
      title: Text("title"),
      content: Text("content"),
      isActive: true,
//      subtitle: Text("subTitle"),
//      state: StepState.complete
    ),
    Step(
        title: Text("title"),
        content: Text("content"),
        isActive: true,
        subtitle: Text("subTitle"),
        state: StepState.indexed),
    Step(
        title: Text("title"),
        content: Text("content"),
        isActive: true,
        subtitle: Text("subTitle"),
        state: StepState.disabled),
    Step(
        title: Text("title"),
        content: Text("content"),
        isActive: true,
        subtitle: Text("subTitle"),
        state: StepState.error),
    Step(
        title: Text("title"),
        content: Text("content"),
        isActive: true,
        subtitle: Text("subTitle"),
        state: StepState.editing),
  ];

  @override
  void initState() {
    bloc = BlocProvider.of<Page2Bloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushPage(RouteName.page3, context, blocQuery: {"key1": "test1"});
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Hero(
              tag: "testHeroTag",
              child: FlutterLogo(
                size: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("page2"),
            ),
            TextStyleAnimatedWidget(
              style: currentIndex == 0
                  ? TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 30,
                    )
                  : TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Text("asdaskdjlaksd"),
            ),
            Expanded(
              child: Stepper(
                steps: steps,
                currentStep: currentIndex,
                onStepTapped: (index) {
                  print("onStepTapped $index");
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
