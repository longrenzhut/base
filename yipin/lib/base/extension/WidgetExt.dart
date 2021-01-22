import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/MyFutureBuilder.dart';

extension WidgetExt on Widget{





  InkWell buildInkWell(Function() onTap){

    return InkWell(
      highlightColor: Colors.transparent,
      child: this,
      onTap: onTap,
    );
  }

  Expanded buildExpanded({int flex: 1}){

    return Expanded(
      child: this,
      flex: flex,
    );
  }

  AbsorbPointer buildAbsorbPointer({bool absorbing: true}){

    return AbsorbPointer(
      child: this,
      absorbing: absorbing,
    );
  }

  //AbsorbPointer本身可以接收点击事件，消耗掉事件，而IgnorePointer无法接收点击事件，其下的控件可以接收到点击事件（不是子控件）
  IgnorePointer buildIgnorePointer({bool ignoring: true}){

    return IgnorePointer(
      child: this,
      ignoring: ignoring,
    );
  }


}
