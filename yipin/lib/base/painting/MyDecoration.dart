

import 'package:flutter/material.dart';
import '../utils/CstColors.dart';

class MyDecoration {

  static BoxDecoration buildShapeByRadius({
    Color solid: Colors.transparent,
    Color stroke:Colors.transparent,
    double strokeWidth:0.0,
    double topRightRadius = 0.0,
    double bottomRightRadius = 0.0,
    double topLeftRadius = 0.0,
    double bottomLeftRadius = 0.0,
  }){
    return BoxDecoration(
        color: solid,
        border: Border.all(
            color: stroke,
            width: strokeWidth
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius),
          topRight: Radius.circular(topRightRadius),
          bottomLeft: Radius.circular(bottomLeftRadius),
          bottomRight: Radius.circular(bottomRightRadius),
        )
    );
  }


  static BoxDecoration buildShape({
    Color solid: Colors.transparent,
    Color stroke:Colors.transparent,
    double strokeWidth: 1.0,
    double radius = 0.0,
    DecorationImage image
  }){
    return BoxDecoration(
        image: image,
        color: solid,
        border: Border.all(
            color: stroke,
            width: strokeWidth
        ),
        borderRadius: BorderRadius.circular(radius)
    );
  }


}
