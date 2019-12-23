import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hydhome/base/http/Bundle.dart';
import 'package:hydhome/base/utils/json_utils.dart';
import 'package:hydhome/main/Application.dart';

import 'routes.dart';

class RouterHepler{


  static _navigateTo(BuildContext context, String path,
      {
        Bundle bundle,
        bool replace = false,
        bool clearStack = false,
        Duration transitionDuration = const Duration(milliseconds: 250),
        RouteTransitionsBuilder transitionBuilder}) {


    StringBuffer param = StringBuffer(path);

    int len = 0;

    Map map = bundle?.getData();

    map?.forEach((key,value){
      if(len == 0) {
        String v = "?${key}=${JsonUtils.fluroCnParamsEncode(value)}";
        param.write(v);
      }
      else {
        param.write("&${key}=${JsonUtils.fluroCnParamsEncode(value)}");
      }
      len ++;
    });


    String newPath = param.toString();
    Application.router.navigateTo(context, newPath,
        replace: replace,
        clearStack: clearStack,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        transition: TransitionType.cupertino);
  }


  static void pop(BuildContext context,){
    Application.router.pop(context);
  }

  static void buildPostDetail(BuildContext context,String id){
    Bundle bundle = Bundle();
    bundle.putString("id", id);
    _navigateTo(context,Routes.post_detail,bundle: bundle);
  }

  static void buildHome(BuildContext context){
    _navigateTo(context,Routes.home,replace: true);
  }


}