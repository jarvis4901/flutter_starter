import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:privacy_client/ui/base_page.dart';

class HomePage extends BasePage {
  @override
  BasePageState<BasePage> attachState() {
    return HomePageState();
  }
}

class HomePageState extends BasePageState<HomePage> {
  @override
  void initState() {
    super.initState();
    setAppBarVisible(false);
  }

  @override
  AppBar attachAppBar() {
    return AppBar(title: Text("首页"));
  }

  @override
  void didChangeDependencies() {
    showContent();
  }

  @override
  Widget attachContentWidget(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: Row(
        children: [
          Text(
            "首页内容",
            style: TextStyle(color: Colors.black, fontSize: 18),
          )
        ],
      ),
    ));
  }

  @override
  void onClickErrorWidget() {
    showLoading().then((value) {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}
