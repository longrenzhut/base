
import 'package:flutter/material.dart';
import 'package:base/extension/WidgetExt.dart';
import 'package:base/extension/ListExt.dart';

class BarPreferredSizeWidget extends StatelessWidget implements PreferredSizeWidget{

  final double height;
  final Widget child;

  const BarPreferredSizeWidget({Key key, this.height, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

