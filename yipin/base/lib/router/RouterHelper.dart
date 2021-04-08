import 'package:base/Config.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:base/BaseApp.dart';



const String initRouter = "/";
const String main = "/main";
const String login = "/login";
const String test = "/test";

class RouterHelper{




  static void define(String routePath,Function(BuildContext context, Map<String, dynamic> parameters) builder){
    BaseApp.router.define(routePath, handler: MyHandler(
        func: (context,map){
          return builder(context,map);
        }
    ));
  }


  //获取传值路径
  static String getRoutePath(String path , Map map){
    if(null == map)
      return path;
    String route = path + "?";
    List arguments = [];
    for(String key in map.keys){
      String encodeStr = Uri.encodeComponent("${map[key]}");
      arguments.add("${key}=${encodeStr}");
    }

    route += arguments.join("&");
    return route;

  }

  static Future build(BuildContext context, String path,
      {
        bool replace = false,
        bool clearStack = false,
        Map map,
        Object arguments,
        Duration transitionDuration = const Duration(milliseconds: 250),
        TransitionType transition:TransitionType.inFromRight,
        RouteTransitionsBuilder transitionBuilder}) {

    var routeSettings = arguments == null ? null : RouteSettings(name: path,arguments: arguments);
    return BaseApp.router.navigateTo(context, getRoutePath(path,map),
        replace: replace,
        clearStack: clearStack,
        routeSettings: routeSettings,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        transition: transition);
  }


  static void pop(BuildContext context,{dynamic backValue}){
    BaseApp.router.pop(context,backValue);
  }

}


typedef Widget Func(
    BuildContext context, Map<String, dynamic> parameters);

class MyHandler extends Handler{
  final HandlerType type;
  final Func func;

  MyHandler({this.type = HandlerType.route, this.func}):
        super(type: type,handlerFunc:(_,map){
        var newMap =  map?.map((key, value) => MapEntry(key, value.first));

        return func(_,newMap);
      });
}
