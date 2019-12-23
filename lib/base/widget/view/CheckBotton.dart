import 'package:flutter/material.dart';
import 'package:hydhome/base/utils/Adapt.dart';
import 'package:hydhome/base/utils/UIHelper.dart';

class CheckBotton extends StatefulWidget {

  final int fontSize;
  final Color textcolor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color solid;
  final Color checkedsolid;
  final Color stroke;
  final Color checkedstroke;
  final double strokeWidth;
  final double radius;
  bool checked;

  final String text;

  final double height;
  final double width;

  final Function(bool isCheck) checkFun;


  CheckBotton(this.text,{
    this.checked:false,
    this.textcolor = Colors.white,
    this.fontSize = 12,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.solid = Colors.transparent,
    this.checkedsolid = Colors.transparent,
    this.stroke = Colors.transparent,
    this.checkedstroke = Colors.transparent,
    this.strokeWidth =  0.0,
    this.radius = 0,
    this.height = double.minPositive,
    this.width = double.minPositive,
    this.checkFun ,
  });


  @override
  _TextButtonState createState() => _TextButtonState();
}

class _TextButtonState extends State<CheckBotton> {
  @override
  Widget build(BuildContext context) {
    double w = widget.width == double.minPositive? double.minPositive: Adapt.setWidth(widget.width);
    double h = widget.height == double.minPositive? double.minPositive: Adapt.setHeight(widget.height);

    Color soild = widget.checked ? widget.checkedsolid : widget.solid;
    Color stroke = widget.checked ? widget.checkedstroke : widget.stroke;

    return FlatButton(

        color: soild,
        child: Text(widget.text,style: UIHelper.textStyle(fontsize: widget.fontSize,
            color: widget.textcolor
        ),),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: stroke,
                width: widget.strokeWidth),
            borderRadius: BorderRadius.circular(Adapt.setWidth(widget.radius))
        ),
        colorBrightness: Brightness.dark,
        onPressed: (){
          setState(() {
            widget.checked = !widget.checked;
            if(null != widget.checkFun)
              widget.checkFun(widget.checked);
          });
        },

    );
  }
}
