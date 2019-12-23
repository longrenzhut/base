

import 'dart:collection';

import '../Config.dart';

class Params{

  Map<String,dynamic> map;

  Params(){
    map = HashMap();
    if(Config.isLogin) {
      put("token", Config.token);
    }
//    put("timestamp", System.currentTimeMillis()/1000);
    put("size", 10);
  }

  void put(String key,dynamic value){
    map[key] = value;
  }



}