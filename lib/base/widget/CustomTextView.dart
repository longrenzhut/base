
import '../painting/MyDecoration.dart';

import 'TextView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/MyColors.dart';


class CustomTextView extends StatelessWidget {

  final String title;
  final EdgeInsetsGeometry margin;
  final double size;
  final Color color;
  final Color solid;
  final num radius;
  final Function onTap;
  final num height;
  final num width;
  final EdgeInsetsGeometry padding;

  CustomTextView(this.title,{this.margin, this.size = 10, this.color= MyColors.black,
    this.solid = MyColors.cl_0FB36E, this.radius = 0.0,this.onTap,
    this.width,
    this.height: double.infinity ,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {

    var dec = null == onTap? null :
    MyDecoration.boxDecorationAllRadius(solid: solid,
        radius: radius
    );

    return Container(
      alignment: Alignment.center,
      height: height,
      padding: padding,
      width: width,
      margin: margin,
      decoration: dec,
      child: getView(),
    );
  }

  Widget getView(){
    if(onTap == null)
      return TextView(title,size: size,color: color);

    return Ink(
      decoration: MyDecoration.boxDecorationAllRadius(solid: solid,
          radius: radius
      ),
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          child: TextView(title,size: size,color: color),
        ),
        onTap: onTap,
      ),
    );

  }

}
