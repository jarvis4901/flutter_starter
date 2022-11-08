import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import 'common/router_config.dart' as myrouter;
import 'common/application.dart';
import 'common/common.dart';
import 'net/dio_manager.dart';
import 'ui/splash_page.dart';

/// 在拿不到context的地方通过navigatorKey进行路由跳转：
/// https://stackoverflow.com/questions/52962112/how-to-navigate-without-context-in-flutter-app
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  /** 主题模式 */
  // ThemeData themeData;

  @override
  void initState() {
    super.initState();
    _initAsync();
    Application.eventBus = new EventBus();
    // themeData = ThemeUtils.getThemeData();
    this.registerThemeEvent();
  }

  void _initAsync() async {
    // await User().getUserInfo();
    await DioManager.init();
  }

  /// 注册主题改变事件
  void registerThemeEvent() {
    // Application.eventBus
    //     .on<ThemeChangeEvent>()
    //     .listen((ThemeChangeEvent onData) => this.changeTheme(onData));
  }

  // void changeTheme(ThemeChangeEvent onData) async {
  //   setState(() {
  //     themeData = ThemeUtils.getThemeData();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName, // 标题
      debugShowCheckedModeBanner: false, //去掉debug图标
      // theme: themeData,
      routes: myrouter.Router.generateRoute(), // 存放路由的配置
      navigatorKey: navigatorKey,
      home: SplashPage(), // 启动页
    );
  }

  @override
  void dispose() {
    super.dispose();
    Application.eventBus.destroy();
  }
}
