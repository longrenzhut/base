
import '../../../base/widget/TextView.dart';
import '../../../common/MyColors.dart';
import 'package:flutter/material.dart';

import '../../../base/utils/CstColors.dart';
import '../../../base/widget/tab/indicator/MD2IndicatorSize.dart';



class TabBarWidget extends StatelessWidget implements PreferredSizeWidget{

  final TabBarController controller;
  final bool isScrollable;
  final double height;
  final Decoration indicator;
  final Decoration decoration;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final ValueChanged<int> onTap;

  const TabBarWidget({Key key,this.onTap, this.controller,this.isScrollable:false,this.height:45,this.indicator,this.padding,this.margin, this.decoration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      padding: padding,
      margin: margin,
      height: height,
      child: TabBar(
        controller: controller,
        tabs: List.generate(controller.tabTitles.length, (index) =>
            TextView(controller.tabTitles[index],size: 15,color: null,)),
        indicator: indicator ??MD2Indicator(indicatorColor: MyColors.cl_01C6AC),
        isScrollable: isScrollable,
        labelColor: CstColors.cl_01C6AC,
        unselectedLabelColor: CstColors.cl_7B8290,
        onTap: onTap,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class TabBarController extends TabController {

   List<String> tabTitles;
  final int initialIndex;

  TabBarController({this.tabTitles,this.initialIndex: 0}): super(
      length: tabTitles?.length??0,
      vsync: ScrollableState(),initialIndex: initialIndex
  );

  setTabTitles(List<String> tabTitles){
    this.tabTitles = tabTitles;
  }


}



