

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../ui/TestPage.dart';
import '../../ui/login/page/LoginPage.dart';
import '../../ui/main/page/MainPage.dart';
import '../BaseApp.dart';
import '../Config.dart';
import '../router/RouteModel.dart';
import '../utils/JsonUtils.dart';


class Routes {

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
    RouteModel(main,"首页",MainPage()),
    RouteModel(test,"测试",TestPage())
  ];



  static Future<void> configureRoutes(FluroRouter router) async {

    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
          return null;//LoginPage();
        });



    tabList.forEach((element) {
      router.define(element.path, handler: MyHandler(
          func: (context,map){
           // final args = context.settings.arguments;
            return element.child; //LoginPage();
          }
      ));
    });

    router.define(login, handler: MyHandler(
        func: (context,map){
          return LoginPage();
        }
    ));

  }

}




typedef Widget Func(
    BuildContext context, Map<String, dynamic> parameters);

class MyHandler extends Handler{
  final HandlerType type;
  final Func func;

  MyHandler({this.type = HandlerType.route, this.func}):
        super(type: type,handlerFunc:(_,map){
        return func(_,map);

      });
}
