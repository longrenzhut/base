

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../ui/login/page/LoginPage.dart';
import '../BaseApp.dart';
import '../Config.dart';
import '../router/RouteModel.dart';
import '../utils/JsonUtils.dart';


class Routes {

  static const String initRouter = "/";
  static const String home = "/home";
  static const String login = "/login";
  static const String taskManage = "/taskManage";
  static const String abnormalOrder = "/abnormalOrder";
  static const String order = "/order";



  

  static onGenerateRoute(BuildContext context, RouteSettings settings) {

    // String name = settings.name;
    //
    // if(name == "/"){
    //   return MaterialPageRoute(builder: routes["/generalize"],settings:  settings);
    // }
    // // if (!routes.containsKey(name)) {
    // //   name = '/404';
    // // } else if (!Utils.isLogin() && !whiteRouters.contains(name)) {
    // //   name = '/login';
    // // }
//    if(settings.name == "/"){
//      RouteSettings mySetting = RouteSettings(name: home,arguments: settings.arguments);
//      return BaseApp.router.generator(mySetting);
//    }
    String name = settings.name;
    if(name == "/"){

    }
    return BaseApp.router.generator(settings);
  }

  static List<RouteModel> tabList = [];

  static Future<void> configureRoutes(FluroRouter router) async {

    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
          return null;//LoginPage();
        });




    // tabList.forEach((element) {
    //   router.define(element.path, handler: MyHandler(
    //       func: (context,map){
    //        // final args = context.settings.arguments;
    //         return HomePage(path: element.path,bundle: map,); //LoginPage();
    //       }
    //   ));
    // });

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
        Map<String, dynamic> param = {};
        if(map.length > 0) {
          map?.forEach((key, value) {
            param[key] = JsonUtils.fluroCnParamsDecode(value.first);
          });

        }
        return func(_,param);

      });
}
