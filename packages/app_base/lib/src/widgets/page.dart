import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 有状态页面组件抽象类
abstract class StatefulPageWidget extends StatefulWidget{
  final String title;
  final bool isShowTitle;

  StatefulPageWidget({Key key, this.title='Untitled',this.isShowTitle=true}) : super(key: key);
  
}
abstract class StatefulPageState<T extends StatefulPageWidget> extends State<T>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isShowTitle?AppBar(title: Text(widget.title)):null,
      body: buildBodyWidget(context),
    );
  }
  @protected
  Widget buildBodyWidget(BuildContext context);
}

/// 无状态页面组件抽象类
abstract class StatelessPageWidget extends StatelessWidget{
  final String title;
  final bool isShowTitle;

  StatelessPageWidget({Key key, this.title='Untitled',this.isShowTitle=true,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.isShowTitle?AppBar(title: Text(this.title)):null,
      body: buildBodyWidget(context),
    );
  }
  @protected
  Widget buildBodyWidget(BuildContext context);
}