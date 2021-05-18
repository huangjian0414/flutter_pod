import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class MyHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return HomePage();
  }

}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const platform =
  const MethodChannel('hj.flutter.dev/homePageTouch');

  String centerTitle = '主页';

  Future<void> _touchHomePage() async {
    try {
      final String result = await platform
          .invokeMethod('homePageTouch', {'param': '点击了homePage的按钮'});
      print(result);
      setState(() {
        centerTitle = '原生app的bundleid为：'+result;
      });
    } on PlatformException catch (e) {}

  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return CupertinoPageScaffold(
      child: Center(child: RaisedButton(
        child: Text('$centerTitle'),
        onPressed: _touchHomePage,
        color: Colors.blueAccent,
        textColor: Colors.white,
      )),
    );
  }
}
