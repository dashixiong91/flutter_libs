import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app_ffi/app_ffi.dart' as appFFI;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _logs = <String>[];
  final ScrollController _scrollController = ScrollController();

  Widget _buildLogWidget() {
    List<Widget> logTextList = _logs.map<Widget>((String text) {
      return Text(
        text,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
          inherit: false,
        ),
      );
    }).toList();
    Widget logList = ListView(
      padding: EdgeInsets.all(0),
      controller: _scrollController,
      children: logTextList,
    );
    Widget logWidget = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: logList,
        ),
        Row(
          children: <Widget>[
            RaisedButton(
              child: Text('clear'),
              onPressed: _clearLog,
            ),
          ],
        )
      ],
    );
    return logWidget;
  }
    Widget buildPageWidget(String title, {List<Widget> tools}) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: tools,
              ),
            ),
            Expanded(
              flex: 1,
              child: _buildLogWidget(),
            ),
          ],
        ),
      )),
    );
  }
   @override
  Widget build(BuildContext context) {
    return buildPageWidget('${appFFI.LIBRARY_NAME}_example', tools: <Widget>[
      RaisedButton(
        child: Text('invoke c++.add'),
        onPressed: _onPressed,
      ),
    ]);
  }

  void _onPressed() {
    _addMethod();
  }
  void _addMethod(){
    Random random = Random.secure();
    int a = random.nextInt(100);
    int b = random.nextInt(100);
    // 调用add函数
    int result = appFFI.add(a, b);
    _addLog("add($a,$b)=> $result");
  }

  void _addLog(String log) {
    assert(() {
      debugPrint(log);
      return true;
    }());
    if (_logs.length > 100) {
      _logs.removeAt(0);
    }
    setState(() {
      _logs.add(log);
    });
    _scrollToBottom();
  }
  void _clearLog() {
    setState(() {
      _logs.clear();
    });
  }
  void _scrollToBottom() {
    Future<void>.delayed(Duration(milliseconds: 300), () {
      double maxScrollHeight = _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels != maxScrollHeight) {
        _scrollController.jumpTo(maxScrollHeight);
      }
    });
  }
}
