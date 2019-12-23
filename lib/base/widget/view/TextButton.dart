import 'package:flutter/material.dart';
import 'package:hydhome/base/utils/Adapt.dart';
import 'package:hydhome/base/utils/UIHelper.dart';

class TextButton extends StatefulWidget {

  int fontSize;
  Color textcolor = Colors.white;
  EdgeInsetsGeometry padding;
  EdgeInsetsGeometry margin;
  Color solid;
  Color stroke;
  double strokeWidth;
  double radius;

  String text;


  TextButton(String text,{
    this.textcolor = Colors.white,
    this.fontSize = 12,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.solid = Colors.transparent,
    this.stroke = Colors.transparent,
    this.strokeWidth =  0.0,
    this.radius = 0,
  }){
    this.text = text;
  }


  @override
  _TextButtonState createState() => _TextButtonState();
}

class _TextButtonState extends State<TextButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(widget.text,style: UIHelper.textStyle(fontsize: widget.fontSize,color: widget.textcolor)),
        padding: widget.padding,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: widget.solid,
          border: Border.all(color: widget.stroke, width: Adapt.setWidth(widget.strokeWidth)),//边框

          borderRadius: BorderRadius.all(//圆角
            Radius.circular(Adapt.setWidth(widget.radius)),
          ),

        )
    );
  }
}
