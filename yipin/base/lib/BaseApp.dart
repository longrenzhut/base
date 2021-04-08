

import 'package:base/http/HttpsProvider.dart';
import 'package:base/utils/ChangeUtils.dart';
import 'package:base/utils/LoginUtils.dart';
import 'package:fluro/fluro.dart';

import 'cache/Cache.dart';


class BaseApp{

  static FluroRouter _router;


  static FluroRouter get router => _router;

  static void init() async{

    HttpUtils.init();
    _router = FluroRouter();


//    GetIt.instance.registerSingleton(NavigateService());
    await Cache.initSp();
    LoginUtils.instance().init();
    ChangeUtils.init();
  }





  }