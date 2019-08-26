import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 页面组件抽象类
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