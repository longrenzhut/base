
import 'package:flutter/material.dart';

import '../../../base/utils/CstColors.dart';
import '../../../base/widget/tab/indicator/MD2IndicatorSize.dart';



class TabBarWidget extends StatelessWidget implements PreferredSizeWidget{

  final TabBarController controller;
  final bool isScrollable;
  final double height;

  const TabBarWidget({Key key, this.controller,this.isScrollable:false,this.height:46}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TabBar(
        controller: controller,
        tabs: List.generate(controller.tabTitles.length, (index) =>
            Text(controller.tabTitles[index],style: TextStyle(fontSize: 14),)),
        indicator: MD2Indicator(),
        isScrollable: isScrollable,
        labelColor: CstColors.cl_0FB36E,
        unselectedLabelColor: Colors.black,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class TabBarController extends TabController {

  final List<String> tabTitles;
  final int initialIndex;

  TabBarController({this.tabTitles,this.initialIndex: 0}): super(
      length: tabTitles.length,
      vsync: ScrollableState(),initialIndex: initialIndex
  );


}



