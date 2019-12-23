import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "自学中",
      theme: ThemeData(
        primarySwatch: Colors.green,//主题色
        primaryColor: Colors.blue,//导航栏颜色
        canvasColor: Colors.grey,//画布颜色
      ),
      home: Container(
        color: Colors.grey[350],
        child: MyHomePage(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("dsfafad"),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: 90,
              height: 90,
              color: Colors.green,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 30,
                height: 30,
                color: Colors.blue,
              ),
            ),
          ],
        )

    );
  }
}
