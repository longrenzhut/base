import 'package:flutter/material.dart';

class MyVisibility extends Visibility{


  MyVisibility({
    Key key,
    Widget child,
    bool placeholder: true,
    bool visible,
}): super(key:  key,child: child,maintainSize: true,visible: visible);
}
