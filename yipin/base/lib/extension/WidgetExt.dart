import 'package:flutter/material.dart';

extension WidgetExt on Widget{


  InkWell buildInkWell(Function() onTap){

    return InkWell(
      child: this,
      onTap: onTap,
    );
  }

  GestureDetector buildFocusScope(BuildContext context){

    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: this
    );
  }

  Ink buildInk({Function() onTap,Decoration decoration,double radius:0.0}){

    return Ink(
      decoration: decoration,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: this,
        onTap: onTap,
      ),
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
