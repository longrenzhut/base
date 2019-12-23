
import 'package:flutter/material.dart';
import 'package:hydhome/base/provider/view_state_model.dart';
import 'package:hydhome/main/adapter/MyTabAdapter.dart';
import 'package:hydhome/ui/appoint/appoint_page.dart';
import 'package:hydhome/ui/bar/bar_page.dart';
import 'package:hydhome/ui/message/message_page.dart';
import 'package:hydhome/ui/my/my_page.dart';
import 'package:hydhome/ui/order/order_page.dart';
import 'package:hydhome/ui/wealth/wealth_page.dart';
import 'package:hydhome/ui/workorder/work_order_page.dart';

class TabModel extends ViewStateModel{




  List<MyTab> tablist = [];
  List<Widget> contentlist = [];

  void setType(int type){
    tablist.clear();
    tablist.add(MyTab("财吧","bar","bar_sel"));
    if(type == 1 || type == null || type == 5)
      tablist.add(MyTab("财富","fortune","fortune_sel"));
    else if(type == 2)
      tablist.add(MyTab("订单","order_form","order_form_sel"));
    else
      tablist.add(MyTab("工单","work_order","work_order_sel"));
    tablist.add(MyTab("预约","order","order_sel"));
    tablist.add(MyTab("消息","message","message_sel"));
    tablist.add(MyTab("我的","my","my_sel"));

    contentlist.clear();
    contentlist.add(BarPage());
    if(type == 1 || type == null || type == 5)
      contentlist.add(WealthPage());
    else if(type == 2)
      contentlist.add(OrderPage());
    else
    contentlist.add(WorkOrderPage());
    contentlist.add(AppointPage());
    contentlist.add(MessagePage());
    contentlist.add(MyPage());

    notifyListeners();
  }




}