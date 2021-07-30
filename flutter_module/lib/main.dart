import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/HomePage.dart';

void main() => runApp(MyApp());

///不同的入口
@pragma('vm:entry-point')
void otherMain() => runApp(MyApp(isOther: true,));


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool isOther;
  MyApp({this.isOther = false});

  @override
  Widget build(BuildContext context) {

    Widget home = isOther?MyHome():MyHomePage(title: 'Flutter Demo Home Page');
    print(home);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: home,
      routes: <String, WidgetBuilder>{
        "/homePage": (context) => MyHome()
      } ,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  static const platform =
  const MethodChannel('hj.flutter.dev/pushToNative');

  Future<void> _pushToNative() async {
    try {
      final int result = await platform
          .invokeMethod('pushToNative', {'param': _counter});
      print(result);
    } on PlatformException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {

    Widget nativeView = (defaultTargetPlatform==TargetPlatform.iOS)?UiKitView(viewType: 'HJNativeView'):AndroidView(viewType: 'plugins.hj/hjView');

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(child: nativeView,width: 80,height: 80,color: Colors.red,),

          RaisedButton(
            child: Text('去原生界面'),
            onPressed: _pushToNative,
            color: Colors.blueAccent,
            textColor: Colors.white,
          ),
          Text(
            "Flutter 页面",
            style: new TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
              fontFamily: "Georgia",
            ),
          )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
