import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hydhome/base/utils/json_utils.dart';
import 'package:hydhome/main/SplashPage.dart';
import 'package:hydhome/main/tab_page.dart';
import 'package:hydhome/ui/bar/post_detail_page.dart';


class Routes {
  static String splash = "/";
  static String home = "/home";
  static String login = "/login";
  static String post_detail = "/bar/postdetail";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
          return null;//LoginPage();
        });


    router.define(splash, handler: MyHandler(
        func: (_,map){
          return SplashPage();
        }
    ));

    router.define(home, handler: MyHandler(
        func: (_,map){
          return TabPage();
        }
    ));

    router.define(post_detail, handler: MyHandler(
        func: (_,map){
          String id = map["id"];
          return PosDetailPage(id:id);
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
