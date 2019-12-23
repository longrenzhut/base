
import 'package:flutter/material.dart';
import 'package:hydhome/base/utils/Adapt.dart';

class SpaceWidget extends StatelessWidget {

  double space = 0;
  Color color = Colors.transparent;

  bool isVerSpace = true;

  SpaceWidget(double space,{this.color,this.isVerSpace = true}){
    this.space = space;
  }

  @override
  Widget build(BuildContext context) {
    double height = isVerSpace? space: 1;
    double width = isVerSpace? null: space;


    return Container(
      color: color,
      height: Adapt.setWidth(height),
      width:  width == null? null :Adapt.setWidth(width),
    );
  }
}
