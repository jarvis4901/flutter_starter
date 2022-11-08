import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:privacy_client/ui/index.dart';
import 'package:privacy_client/ui/splash_page.dart';
import 'package:privacy_client/ui/home_page.dart';

/// 存放路由的配置
class RouterName {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String home = 'home';
}

class Router {
  static Map<String, WidgetBuilder> generateRoute() {
    Map<String, WidgetBuilder> routes = {
      RouterName.splash: (context) => new SplashPage(),
      RouterName.home: (context) => new HomePage(),
    };
    return routes;
  }
}
