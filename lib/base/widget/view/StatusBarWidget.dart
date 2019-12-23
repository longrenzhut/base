
import 'package:flutter/material.dart';
import 'package:hydhome/base/utils/Adapt.dart';

class StatusBarWidget extends StatelessWidget {

  Color color = Colors.transparent;


  StatusBarWidget({this.color}){
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: color,
      height: Adapt.statusBarH,
    );
  }
}
