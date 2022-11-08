import 'package:flutter/material.dart';
import 'package:privacy_client/ui/home_page.dart';
import 'package:privacy_client/utils/utils.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => HomePage()),
          (route) => route == null);
    });
  }

  @override
  Widget build(BuildContext context) {
    // ScreenAdapter.init(context);
    return new Center(
      child: Stack(
        children: <Widget>[
          Container(
            // 欢迎页面
            color: Theme.of(context).primaryColor,
            // ThemeUtils.dark ? Color(0xFF212A2F) : Colors.grey[200],
            alignment: Alignment.center,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[Text("welcome")],
            ),
          )
        ],
      ),
    );
  }
}
