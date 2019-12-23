
import 'package:flutter/material.dart';
import 'package:hydhome/base/common/BaseNoPage.dart';
import 'package:hydhome/base/common/BasePage.dart';

class WealthPage extends BasePage{

  WealthPage():super(
    title:"测试",
    isLeft:true
  );

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    return Container(
      width: 100,
      height: 100,
      child: Text("dfsdf"),
    );
  }

  @override
  void initWidget(BuildContext context) {

  }

}