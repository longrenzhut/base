import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../BaseApp.dart';
import '../utils/JsonUtils.dart';
import 'routes.dart';

class RouterHelper{


  static Future _navigateTo(BuildContext context, String path,
      {
        bool replace = false,
        bool clearStack = false,
        RouteSettings  routeSettings,
        Duration transitionDuration = const Duration(milliseconds: 250),
        TransitionType transition:TransitionType.cupertino,
        RouteTransitionsBuilder transitionBuilder}) {


    return BaseApp.router.navigateTo(context, path,
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

//  static void buildPostDetail(BuildContext context,String id){
//    Bundle bundle = Bundle();
//    bundle.putString("id", id);
//    _navigateTo(context,Routes.post_detail,bundle: bundle);
//  }

  static Future build(BuildContext context,RouteSettings  routeSettings,{bool replace: false}){
   return _navigateTo(context,routeSettings.name,routeSettings: routeSettings,replace: replace);
  }




  static void buildMain(BuildContext context){
    _navigateTo(context,Routes.main,replace: true);
  }


  static void buildLogin(BuildContext context){
    _navigateTo(context,Routes.login,clearStack: true,replace: true);
  }





}