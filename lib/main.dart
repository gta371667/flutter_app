import 'package:flutter/material.dart';
import 'package:flutter_app/route/route_mixin.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/i18n.dart';
import 'route/route_name.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget with RouteMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      initialRoute: RouteName.page1,
//      routes: {RouteName.page1: (context) => AppRouter.getPage(RouteName.page1, null)},
      /// route history routeName = "/"
      home: getPage(RouteName.page1),
      onGenerateTitle: (context) {
        return S.of(context).appName;
      },
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: S.delegate.resolution(
        fallback: S.delegate.supportedLocales.last,
        withCountry: false,
      ),
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
