
import 'package:flutter/material.dart';

import '../../../base/view/BaseWidget.dart';
import 'BarPreferredSizeWidget.dart';
import 'TabBarWidget.dart';

class TabPageWidget extends StatefulWidget {

  final List<String> tabTitles;
  final List<Widget> pages;
  final double barHeight;
  final TabPageController controller;

  const TabPageWidget({Key key,this.tabTitles, this.barHeight:54, this.controller,this.pages}) : super(key: key);
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
        appBar: TabBarWidget(
          height: widget.barHeight,
          controller: controller.controller,
        ),
        body: TabBarView(
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