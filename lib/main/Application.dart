

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hydhome/base/cache/Cache.dart';
import 'package:hydhome/base/http/HttpProvider.dart';
import '../base/router/navigate_service.dart';
import '../base/router/routes.dart';
import '../base/utils/Adapt.dart';

class Application{


  static Router _router;


  static Router get router => _router;

  static void init(){

    Adapt.getInstance().init();
    HttpProvider.init();
    _router = Router();
    Routes.configureRoutes(router);

    GetIt.instance.registerSingleton(NavigateService());

  }


  
}