import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/page3_bloc.dart';
import 'package:flutter_app/route/hero_tag.dart';

class HeroDialogWidget extends StatelessWidget {
  final String heroTag;
  final Page3Bloc bloc;

  const HeroDialogWidget({
    Key key,
    @required this.heroTag,
    @required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.3,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          StreamBuilder<String>(
              stream: bloc.heroTagStream,
              builder: (context, snapshot) {
                String tag = snapshot.data;

                return Container(
                  color: Colors.yellow,
                  child: Hero(
                    flightShuttleBuilder: (
                      flightContext,
                      animation,
                      direction,
                      fromContext,
                      toContext,
                    ) {
                      return Icon(
                        Icons.error,
                        size: 50.0,
                      );
                    },
                    tag: tag ?? heroTag,
                    child: Image.asset(
                      "assets/images/gbf_bi.jpg",
                      height: 80,
                      width: 80,
                    ),
                  ),
                );
              }),
          FlatButton(
            color: Colors.yellow,
            onPressed: () {
              bloc.setHeroTag(HeroTag.favorite);
              Navigator.of(context).pop();
            },
            child: Text("buy"),
          ),
        ],
      ),
    );
  }
}
