
import 'dart:collection';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class Cache{



  Cache(){
    initMap();
  }

  static Cache inst;

  static Cache instance(){
    if(null == inst)
      inst = Cache();

    return inst;
  }

  static SharedPreferences cache;

  static initSp() async{
    cache = await SharedPreferences.getInstance();
  }



  Map<String,Object> cacheMap;

  void initMap(){
    if(null == cacheMap)
      cacheMap = new HashMap<String,Object>();
  }

  /**
   * 设置值
   */
  void put(String key, String value){
    String newValue = cacheMap[key];
    if(null != newValue && newValue == value){
      return;
    }
    cacheMap[key]  = value;
    Cache.cache.setString(key,value);
  }


  String getString(String key, {String defalut = ""}){
    String newValue = cacheMap[key];
    if(null != newValue)
      return  newValue;
    if(Cache.cache.containsKey(key)) {
      String value = Cache.cache.getString(key);
      if (null != value) {
        cacheMap[key] = value;
        return value;
      }
      else
        return defalut;
    }
    else{
      return defalut;
    }

  }


  void putInt(String key, int values){
    put(key, values.toString());
  }

  int getInt(String key, {int defalut = 0}){
    var value =  getString(key,defalut: defalut.toString());
    if(value == null)

      return int.parse(value);
    return defalut;
  }

  void clear(){
    cacheMap.clear();
    Cache.cache.clear();
  }


  void remove(String key){
    cacheMap.remove(key);
    Cache.cache.remove(key);
  }

//  <T> void putEntity(String key, T entity) {
//    put(key, new Gson().toJson(entity));
//  }
//
//  <T> T getEntity(String key, Class<T> tClass){
//    String value = getString(key,"");
//    if(value == "")
//      return null;
//    return new Gson().fromJson(value, tClass);
//  }



}