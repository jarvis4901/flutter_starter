import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//页面基础类
abstract class BasePage extends StatefulWidget {
  late BasePageState basePageState;

  @override
  State<StatefulWidget> createState() {
    basePageState = attachState();
    return basePageState;
  }

  BasePageState attachState();
}

abstract class BasePageState<T extends BasePage> extends State<T>
    with AutomaticKeepAliveClientMixin {
  /// 导航栏是否显示
  bool _isAppBarShow = true;

  /// 错误信息是否显示
  bool _isErrorWidgetShow = false;
  String _errorContentMsg = "网络请求失败，请检查您的网络";
  String _errorImgPath = "assets/images/ic_error.png";

  bool _isLoadingWidgetShow = false;

  bool _isEmptyWidgetShow = false;
  String _emptyContentMsg = "暂无数据";
  String _emptyImgPath = "assets/images/ic_empty.png";

  bool _isShowContent = false;

  /// 错误页面和空页面的字体粗度
  FontWeight _fontWidget = FontWeight.w600;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[],
        ),
      ),
    );
  }
}
