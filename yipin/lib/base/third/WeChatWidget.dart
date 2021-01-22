

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import '../utils/ImageHelper.dart';
import '../utils/ToastUtil.dart';
import '../view/BaseWidget.dart';

class WeChatWidget extends StatefulWidget {

  final WeChatController controller;
  final Function(WxUserModel model) callback;

  const WeChatWidget({Key key, this.controller, this.callback}) : super(key: key);

  @override
  _WeChatWidgetState createState() => _WeChatWidgetState();
}

class _WeChatWidgetState extends BaseWidgetState<WeChatWidget,WeChatController> {

  @override
  WeChatController getController() =>  widget.controller?? WeChatController();


  @override
  void initState(){
    super.initState();
    init();
  }


  void init() async{
    var isRegister = await fluwx.registerWxApi(
        appId: controller.appId,
        doOnAndroid: true,
        doOnIOS: true);

    fluwx.weChatResponseEventHandler.listen((event) {
      int errCode = event.errCode;
      if(errCode == 0){
        if(event is fluwx.WeChatAuthResponse){
          controller.requestToken(event.code);
        }
      }
    });
    controller?.setCallback(widget.callback);
  }




  @override
  Widget build(BuildContext context) {
    return InkWell(child: ImageHelper.buildImage("ic_wx.png",width: 56,height: 56)
      ,onTap: () async{
        var isWeChatInstalled = await fluwx.isWeChatInstalled;
        if(isWeChatInstalled){
          var send = await fluwx.sendWeChatAuth(scope: "snsapi_userinfo", state: "wechat_sdk_demo_test");
        }
        else
          ToastUtil.showToast("请安装微信");
      },
    );
  }
}


class WeChatController extends BaseWidgetController{


  String appId = "wx4668275c09acfe67";
  String appSecret = "0b99c9fa4634cbfc03779f7fec36ebfa";

  WxUserModel _wxUserModel;


  WxUserModel get wxUserModel => _wxUserModel;

  set wxUserModel(WxUserModel value) {
    _wxUserModel = value;
    setValue(value.accessToken);
  }

  Function(WxUserModel model) callback;

  setCallback(Function(WxUserModel model) callback){
    this.callback = callback;
  }

  void requestToken(String code) async{
    var result = await getByMap("https://api.weixin.qq.com/sns/oauth2/access_token",
        {"appid": appId,"secret":appSecret,"code":code,"grant_type":"authorization_code"}
    );
    if(null != result){
      var model = WxUserModel.fromJson(json.decode(result));
      requestUser(model);
    }
    else{
      ToastUtil.showToast("微信登录失败");
    }
  }


  void requestUser(WxUserModel model) async{
    var result = await getByMap("https://api.weixin.qq.com/sns/userinfo",
        {"access_token": model.accessToken,"openid":model.openid}
    );
    if(null != result){
      model.setFromJson(json.decode(result));
      wxUserModel = model;
      callback?.call(model);
    }
    else{
      ToastUtil.showToast("微信登录失败");
    }
  }



}

/// access_token : "41_serf0slOK835wzy9kVbNKKBRlVQ-s-sFaUkD4h95IiCSRr4I3iX6tAdcBaN0YB3AZrLWtlgwvr4WYME7Ni4vXfogA21_7UItoSpPpOCj9Gs"
/// expires_in : 7200
/// refresh_token : "41_34U1a_KipCnGCy07E2EvT00J5JIDaVjgLC0b_DSmTvVw3QT4rZd3V3llMdxSCrMTr205F1C6THXcR4weOeg1fx0n87xGLsmrOAh_IeqT56o"
/// openid : "oMWf01PNQ2HpKcMlxqVxYCJX96N0"
/// scope : "snsapi_userinfo"
/// unionid : "oGJWzwU294yZrTgn_OXTMKOQ7hyY"

class WxUserModel {


  String _accessToken;
  int _expiresIn;
  String _refreshToken;
  String _openid;
  String _scope;
  String _unionid;

  String _nickname;
  int _sex;
  String _language;
  String _city;
  String _province;
  String _country;
  String _headimgurl;

  String get accessToken => _accessToken;
  int get expiresIn => _expiresIn;
  String get refreshToken => _refreshToken;
  String get openid => _openid;
  String get scope => _scope;
  String get unionid => _unionid;

  WxUserModel({
    String accessToken,
    int expiresIn,
    String refreshToken,
    String openid,
    String scope,
    String unionid}){
    _accessToken = accessToken;
    _expiresIn = expiresIn;
    _refreshToken = refreshToken;
    _openid = openid;
    _scope = scope;
    _unionid = unionid;
  }

  WxUserModel.fromJson(dynamic json) {
    _accessToken = json["access_token"];
    _expiresIn = json["expires_in"];
    _refreshToken = json["refresh_token"];
    _openid = json["openid"];
    _scope = json["scope"];
    _unionid = json["unionid"];
  }


  String get nickname => _nickname;

  set nickname(String value) {
    _nickname = value;
  }

  void setFromJson(dynamic json) {
    _nickname = json["nickname"];
    _sex = json["sex"];
    _city = json["city"];
    _province = json["province"];
    _country = json["country"];
    _headimgurl = json["headimgurl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["access_token"] = _accessToken;
    map["expires_in"] = _expiresIn;
    map["refresh_token"] = _refreshToken;
    map["openid"] = _openid;
    map["scope"] = _scope;
    map["unionid"] = _unionid;
    return map;
  }

  int get sex => _sex;

  set sex(int value) {
    _sex = value;
  }

  String get language => _language;

  set language(String value) {
    _language = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get province => _province;

  set province(String value) {
    _province = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String get headimgurl => _headimgurl;

  set headimgurl(String value) {
    _headimgurl = value;
  }
}