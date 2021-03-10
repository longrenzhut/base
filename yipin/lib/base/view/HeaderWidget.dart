

import 'package:flutter/material.dart';
import '../../common/MyColors.dart';
import '../../base/router/RouterHelper.dart';
import '../../base/utils/ImageHelper.dart';
import '../../base/widget/TextView.dart';
import '../../base/view/BaseWidget.dart';
import '../../base/extension/WidgetExt.dart';
import '../../base/extension/ListExt.dart';

class HeaderWidget extends StatefulWidget  implements PreferredSizeWidget{


  final HeaderController controller;
  final Color bgColor;
  final String backIcon;
  final String title;
  final Function() leftCallback;
  final String tvLeft;
  final Function() rightTvCallback;
  final List<Widget> leftChildren;
  final List<Widget> rightChildren;

  const HeaderWidget({Key key, this.controller, this.bgColor, this.backIcon, this.title, this.leftCallback,
    this.tvLeft:"", this.rightTvCallback, this.leftChildren, this.rightChildren
  }) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();

  @override
  Size get preferredSize => null;

}

class _HeaderWidgetState extends BaseWidgetState<HeaderWidget,HeaderController> {

  @override
  HeaderController getController() =>  widget.controller??HeaderController();

  @override
  void initState() {
    super.initState();
    controller.bgColor = widget.bgColor;
    controller.backIcon = widget.backIcon;
    controller.leftCallback = widget.leftCallback;
    controller.tvLeft = widget.tvLeft;
    controller.rightTvCallback = widget.rightTvCallback;
    controller.leftChildren = widget.leftChildren;
    controller.rightChildren = widget.rightChildren;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: controller.bgColor,
      shadowColor: Colors.transparent,
      leadingWidth: controller.backIcon.isEmpty ? 0 : 44,
      leading: controller.backIcon.isEmpty ? null : Container(
        margin: EdgeInsets.only(left: 16),
        child: ImageHelper.buildImage(controller.backIcon,width: 28,height: 28,type: 1,fit: BoxFit.fitWidth).buildInkWell(() {
          if(null == controller.leftCallback)
            RouterHelper.pop(context);
          else
            controller.leftCallback?.call();
        }),
      ),
      title: TextView(controller.title,size: 18, weight: FontWeight.bold, color: MyColors.cl_1F2736,),
      actions: [
        ...controller.leftChildren??[],
        controller.tvLeft.isNotEmpty ? Container(
          alignment: Alignment.center,
          child: TextView(controller.tvLeft,size: 16, color: MyColors.cl_00AC96,).buildInkWell(() {
          }),
        ): SizedBox.shrink(),
        ...controller.rightChildren??[],
        SizedBox(width: 16,)
      ],
    );
  }
}

class HeaderController extends BaseWidgetController{

  Color bgColor;
  String backIcon;
  Function() leftCallback;
  String title;

  String tvLeft;
  Function() rightTvCallback;

  List<Widget> leftChildren;
  List<Widget> rightChildren;


  void setTitle(String title,{Color bgColor, String backIcon, Function() leftCallback,
    String tvLeft,
    Function() rightTvCallback,
    List<Widget> leftChildren,
    List<Widget> rightChildren
  }){
    this.title = title;
    this.bgColor = bgColor;
    this.backIcon = backIcon;
    this.leftCallback = leftCallback;
    this.tvLeft = tvLeft;
    this.rightTvCallback = rightTvCallback;
    this.leftChildren = leftChildren;
    this.rightChildren = rightChildren;
  }
}

