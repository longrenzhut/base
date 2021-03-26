
import 'package:flutter/material.dart';

import '../../base/widget/BaseWidget.dart';
import 'BarPreferredSizeWidget.dart';
import 'TabBarWidget.dart';

class TabPageWidget extends StatefulWidget {

  final List<String> tabTitles;
  final List<Widget> pages;
  final double barHeight;
  final TabPageController controller;

  final Decoration indicator;
  final Decoration decoration;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final ScrollPhysics barPhysics;

  const TabPageWidget({Key key,this.tabTitles,this.barPhysics, this.barHeight:54, this.controller,this.pages, this.indicator, this.decoration, this.padding, this.margin}) : super(key: key);
  @override
  _TabPageWidgetState createState() => _TabPageWidgetState();
}

class _TabPageWidgetState extends BaseWidgetState<TabPageWidget,TabPageController> {
  
  @override
  TabPageController getController() =>  widget.controller??TabPageController();

  @override
  void initState() {
    super.initState();
    controller.initTabBarController(widget.tabTitles);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: TabBarWidget(
          indicator:widget.indicator,
          decoration:widget.decoration,
          padding:widget.padding,
          margin:widget.margin,
          height: widget.barHeight,
          controller: controller.controller,
        ),
        body: TabBarView(
          physics: widget.barPhysics,
          controller: controller.controller,
          children: widget.pages,
        ),
    );
  }
}

class TabPageController extends BaseWidgetController{

   TabBarController controller ;

   initTabBarController(List<String> tabTitles){
     controller = TabBarController(tabTitles: tabTitles);
   }


   @override
  void dispose() {
     controller?.dispose();
    super.dispose();
  }

}