
import 'dart:convert';

import '../utils/BaseUtils.dart';

import '../Config.dart';
import '../cache/Cahes.dart';
import '../model/UserModel.dart';

class LoginUtils {
  static LoginUtils _inst;

  static LoginUtils instance(){
    if(null == _inst)
      _inst = LoginUtils();

    return _inst;
  }

  UserModel mUserModel;

  void init() {
    var userInfo = Caches.getVar().getString(Caches.USER);
//    var userInfo = LocalStorageUtil.get(Caches.USER);
    if(BaseUtils.isEmpty(userInfo)){
      return;
    }
    mUserModel = UserModel.fromJson(json.decode(userInfo));
    Config.isLogin = true;
    Config.token = mUserModel?.token;
  }


  UserModel getUser()=> mUserModel;

  void logout(){
    Caches.getVar().remove(Caches.USER);
    mUserModel = null;
    Config.isLogin = false;
    Config.token = "";

  }

  void putMobile(String phone){
    if(null != mUserModel) {
      mUserModel.phone = phone;
      if(!BaseUtils.isEmpty(phone)){
        var first = phone.substring(0,3);
        var sec = phone.substring(phone.length - 3);
        mUserModel.codingPhone = "${first}****${sec}";
      }
      var value = json.encode(mUserModel.toJson());
//    LocalStorageUtil.set(Caches.USER, value);
      Caches.getVar().put(Caches.USER, value);
    }
  }

  bool isBindPhone(){
    return !BaseUtils.isEmpty(mUserModel?.phone);
  }

  void intoLogin(UserModel model){
    if(null != mUserModel)
      model.token = mUserModel?.token;
    if(!BaseUtils.isEmpty(model.phone)){
      var first = model.phone.substring(0,3);
      var sec = model.phone.substring(model.phone.length - 3);
      model.codingPhone = "${first}****${sec}";
    }

    mUserModel = model;
    Config.isLogin = true;
    Config.token = model?.token;

    var value = json.encode(model.toJson());
//    LocalStorageUtil.set(Caches.USER, value);
    Caches.getVar().put(Caches.USER, value);
  }

}
