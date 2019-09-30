import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app_ffi/app_ffi.dart' as appFfi;

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
    Widget logWidget = ListView(
      padding: EdgeInsets.all(0),
      controller: _scrollController,
      children: logTextList,
    );
    return logWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${appFfi.LIBRARY_NAME}_example'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('invoke native.method'),
              onPressed: _onPressed,
            ),
            Expanded(
              flex: 1,
              child: _buildLogWidget(),
            )
          ],
        ),
      ),
    );
  }

  void _onPressed() {
    // _addMethod();
    // _mainMethod();
    _boxClass();

  }
  void _boxClass(){
    appFfi.Box box=appFfi.Box(1,2,3);
    _addLog("box.getVolume()=>${box.getVolume()}");
  }
  void _mainMethod(){
    appFfi.main();
  }
  void _addMethod(){
    Random random = Random.secure();
    int a = random.nextInt(100);
    int b = random.nextInt(100);
    // 调用add函数
    int result = appFfi.add(a, b);
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

  void _scrollToBottom() {
    Future<void>.delayed(Duration(milliseconds: 300), () {
      double maxScrollHeight = _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels != maxScrollHeight) {
        _scrollController.jumpTo(maxScrollHeight);
      }
    });
  }
}
