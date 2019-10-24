import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/page1_bloc.dart';
import 'package:flutter_app/bloc/page2_bloc.dart';
import 'package:flutter_app/bloc/page3_bloc.dart';

import 'bloc_provider.dart';
import 'my_route.dart';
import 'route_name.dart';

mixin RouteMixin {
  /// [routeName] 路由名稱
  /// [blocQuery] 帶值至bloc
  /// [pushAndReplace] 是否要覆蓋當前路由，並重新pushPage一次
  /// [pushAndRemoveUntil] 一直pop至指定路由，並push新的[routeName]
  Future<T> pushPage<T>(
    String routeName,
    BuildContext context, {
    Map<String, dynamic> blocQuery,
    bool pushAndReplace = false,
    bool Function(String route) pushAndRemoveUntil,
    PageRoute<T> pageRoute,
  }) {
    var navigator = Navigator.of(context);
    var pageWidget = _getPage(routeName, blocQuery);

    if (pageRoute == null) {
      pageRoute = MaterialPageRoute<T>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => pageWidget,
      );
    }

    if (pushAndRemoveUntil != null) {
      return navigator.pushAndRemoveUntil(pageRoute, (rt) {
        bool check = pushAndRemoveUntil(rt.settings.name);
        debugPrint("pushAndRemoveUntil 當前RouteName：${rt.settings.name} 是否Pop：${!check}");
        return check;
      });
    } else if (pushAndReplace) {
      return navigator.pushReplacement(pageRoute);
    } else {
      return navigator.push(pageRoute);
    }
  }

  /// [popUntil] 返回至指定頁
  /// [result] 返回值，[popUntil]為空才有效
  bool pop<T>(
    BuildContext context, {
    bool Function(String route) popUntil,
    Object result,
  }) {
    var navigator = Navigator.of(context);

    if (popUntil != null) {
      navigator.popUntil((rt) {
        bool check = popUntil(rt.settings.name);

        if (!navigator.canPop()) {
          debugPrint("popUntil 已經無法再返回");
          return true;
        } else {
          return check;
        }
      });
      return true;
    } else {
      if (!navigator.canPop()) {
        debugPrint("canPop 已經無法再返回");
        return true;
      } else {
        return navigator.pop(result);
      }
    }
  }

  Widget _getPage(String routeName, Map<String, dynamic> query) {
    final child = AppRouter.getPage(routeName, query);

    switch (routeName) {
      case RouteName.page1:
        return BlocProvider(
          child: child,
          bloc: Page1Bloc(BlocOption(query)),
        );
      case RouteName.page2:
        return BlocProvider(
          child: child,
          bloc: Page2Bloc(BlocOption(query)),
        );
      case RouteName.page3:
        return BlocProvider(
          child: child,
          bloc: Page3Bloc(BlocOption(query)),
        );
      default:
        throw ("RouteMixin 無找到對應Page");
    }
  }
}
