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

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("dsfafad"),
        ),
        body: ListView.separated(
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.all(8),
              height: 80,
              color: Colors.amber[colorCodes[index]],
              child: Center(child: Text('Entry ${entries[index]}')),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(height: 1,color: Colors.white,),
        )
    );
  }
}
