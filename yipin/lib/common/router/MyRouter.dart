

import 'package:base/BaseApp.dart';
import 'package:base/Config.dart';
import 'package:base/router/RouteModel.dart';
import 'package:base/router/RouterHelper.dart';
import 'package:flutter/material.dart';
import 'package:yipin/main/page/LoginPage.dart';
import 'package:yipin/main/page/MainPage.dart';
import 'package:yipin/main/page/TestPage.dart';


class MyRouter {


  static const String initRouter = "/";
  static const String main = "/main";
  static const String login = "/login";
  static const String test = "/test";

  static onGenerateRoute(BuildContext context, RouteSettings settings) {

    String name = settings.name;
    if(name == "/"){
      if(Config.isLogin){
        return BaseApp.router.generator(RouteSettings(name: main));
      }
      return BaseApp.router.generator(RouteSettings(name: login));
    }
    return BaseApp.router.generator(settings);
  }

  static List<RouteModel> tabList = [
    RouteModel(login,"首页",LoginPage()),
    RouteModel(main,"首页",MainPage()),
    RouteModel(test,"首页",TestPage()),
  ];


  
  static void configureRoutes(){
    tabList?.forEach((element) {
      RouterHelper.define(element.path, (context, parameters) => element.child);
    });

  }


  static buildTest(BuildContext context,{int type:0}){
    RouterHelper.build(context,test,arguments: {"type": type});
  }

  static buildMain(BuildContext context){
    RouterHelper.build(context,main);
  }

  static buildLogin(BuildContext context){
    RouterHelper.build(context,login);
  }


}
