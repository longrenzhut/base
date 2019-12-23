

import 'package:flutter/material.dart';
import 'package:hydhome/base/utils/Adapt.dart';
import 'package:hydhome/base/utils/MyColors.dart';

class UIHelper{


  static TextStyle textSize(int fontsize){
    return TextStyle(fontSize: Adapt.setTextSp(fontsize));
  }

  static EdgeInsets edgeInset({
    double left,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  })
   => EdgeInsets.only(left: left,top: top,right: right,bottom: bottom);

  static EdgeInsets edgeInsetAll(
    double space
  )
   => EdgeInsets.all(space);


  static TextStyle textColor(Color color){
    return TextStyle(color: color);
  }



  static TextStyle textStyle({int fontsize,Color color
    ,FontWeight fontWeight,

  }){
    return TextStyle(color: color,fontSize: Adapt.setTextSp(fontsize),fontWeight: fontWeight);
  }


  static BoxDecoration boxDecoration({
    Color soildColor: Colors.transparent,
    Color borderColor:Colors.transparent,
    int width:1,
    double radius: 0
  }){
    return BoxDecoration(
        color: soildColor,
        border: Border.all(
            color: borderColor,
            width: Adapt.setWidth(width.toDouble())
        ),
        borderRadius: BorderRadius.circular(Adapt.setWidth(radius))
    );
  }

  static EdgeInsets left(Object value){
    return EdgeInsets.only(left:  Adapt.setWidth(value));
  }

  static EdgeInsets right(Object value){
    return EdgeInsets.only(right:  Adapt.setWidth(value));
  }

  static EdgeInsets top(Object value){
    return EdgeInsets.only(top:  Adapt.setWidth(value));
  }

  static EdgeInsets bottom(Object value){
    return EdgeInsets.only(bottom:  Adapt.setWidth(value));
  }

  static EdgeInsets vertical(Object value){
    return EdgeInsets.symmetric(vertical:  Adapt.setWidth(value));
  }

  static EdgeInsets horizontal(Object value){
    return EdgeInsets.symmetric(horizontal:  Adapt.setWidth(value));
  }

  static EdgeInsets only({Object left: 0,Object right: 0,Object top: 0,Object bottom: 0}){
    return EdgeInsets.only(top:  Adapt.setWidth(top),
        right: Adapt.setWidth(right),
        bottom: Adapt.setWidth(bottom),
        left: Adapt.setWidth(left),
    );
  }

  static EdgeInsets all(Object value){
    return EdgeInsets.all(Adapt.setWidth(value));
  }


//      const RaisedButton({
//      Key key,
//      @required VoidCallback onPressed,
//      ValueChanged<bool> onHighlightChanged,//水波纹高亮变化回调,按下返回true,抬起返回false
//      ButtonTextTheme textTheme,//按钮的主题
//      Color textColor,//文字的颜色
//      Color disabledTextColor,//按钮禁用时候文字的颜色
//      Color color,//按钮的背景颜色
//      Color disabledColor,//按钮被禁用的时候显示的颜色
//      Color highlightColor,//点击或者toch控件高亮的时候显示在控件上面，水波纹下面的颜色
//      Color splashColor,//水波纹的颜色
//      Brightness colorBrightness,//按钮主题高亮
//      double elevation,//按钮下面的阴影
//      double highlightElevation,//高亮时候的阴影
//      double disabledElevation,//按下的时候的阴影
//      EdgeInsetsGeometry padding,
//      ShapeBorder shape,//设置形状
//      Clip clipBehavior = Clip.none,
//      MaterialTapTargetSize materialTapTargetSize,
//      Duration animationDuration,
//      Widget child,
//      })

  static Widget Raisedbtn({Widget child,double radius = 10.0, double height,double width,Function f}) {
    return Container(
        child: RaisedButton(
          child: child,
          shape: RoundedRectangleBorder(
            side:  BorderSide(color: Colors.pink),
            borderRadius: BorderRadius.circular(Adapt.setWidth(radius)),
          ),
          color: MyColors.cl_067C5F,
          focusColor: MyColors.cl_aa067C5F,
          onPressed: f,
        )
    );
  }

}