import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/route/my_route.internal.dart';

/// import library [annotation_route: any]、[build_runner : 1.7.1]
/// 1.create [MyRouteOption] @ARouteRoot()
/// 2.create [RouteName] 定義page名稱
/// 3.create WidgetPage 並定義@ARoute url與建構子MyRouteOption
/// 指令1：flutter packages pub run build_runner clean
/// 指令2：flutter packages pub run build_runner build --delete-conflicting-outputs
@ARouteRoot()
class MyRouteOption {
  String urlPattern;
  Map<String, dynamic> query;

  MyRouteOption(this.urlPattern, this.query);
}

class AppRouter {
  static ARouterResult _get(String urlString, Map<String, dynamic> query) {
    ARouterInternalImpl internal = ARouterInternalImpl();
    ARouterResult routeResult = internal.findPage(
      ARouteOption(urlString, query),
      MyRouteOption(urlString, query),
    );
    return routeResult;
  }

  /// 取得匹配路徑的頁面
  static Widget getPage(String urlString, Map<String, dynamic> query, {Widget notFound}) {
    var result = _get(urlString, query);
    if (result.state == ARouterResultState.FOUND) {
      return result.widget;
    }

    /// 返回未匹配路徑的頁面
    return notFound ??
        Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('NOT FOUND'),
          ),
        );
  }

//  static Widget pageFromUrlAndQuery(String urlString, Map<String, dynamic> query) {
//    ARouterInternalImpl internal = ARouterInternalImpl();
//
//    ARouterResult routeResult = internal.findPage(
//      ARouteOption(urlString, query),
//      MyRouteOption(urlString, query),
//    );
//    if (routeResult.state == ARouterResultState.FOUND) {
//      return routeResult.widget;
//    }
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Page Not Found"),
//      ),
//      body: Container(
//        alignment: Alignment.center,
//        child: Text("Not Found"),
//      ),
//    );
//  }
}
