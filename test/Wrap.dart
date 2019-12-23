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
        body: Wrap(
          spacing: 8.0, // gap between adjacent chips
          runSpacing: 4.0, // gap between lines
          children: <Widget>[
            Chip(
              avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('AH')),
              label: Text('Hamilton'),
            ),
            Chip(
              avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('ML')),
              label: Text('Lafayette'),
            ),
            Chip(
              avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('HM')),
              label: Text('Mulligan'),
            ),
            Chip(
              avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('JL')),
              label: Text('Laurens'),
            ),
          ],
        )

    );
  }
}
