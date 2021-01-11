

import '../utils/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LineView extends Container {

  final double top;
  final double right;
  final double left;
  final double bottom;
  final Color color;
  final num height;
  final num width;

  LineView({
    this.color = MyColors.cl_E6EAEE,
    this.top = 0.0,
    this.right = 0.0,
    this.left = 0.0,
    this.bottom = 0.0,
    this.height = 0.5,
    this.width = double.maxFinite
  }) :super(
    margin: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
    color: color,
    width: width,
    height:height,
  );
}
