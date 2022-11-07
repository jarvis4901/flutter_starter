import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:privacy_client/ui/base_page.dart';

class HomePage extends BasePage {
  @override
  BasePageState<BasePage> attachState() {
    // TODO: implement attachState
    throw UnimplementedError();
  }
}

class HomePageState extends BasePageState<HomePage> {
  @override
  AppBar attachAppBar() {
    return AppBar(title: Text("首页"));
  }

  @override
  Widget attachContentWidget(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Text("首页内容"),
    ));
  }

  @override
  void onClickErrorWidget() {
    showLoading().then((value) {});
  }
}
