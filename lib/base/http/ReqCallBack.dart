
import 'package:flutter/material.dart';
import 'package:hydhome/base/Config.dart';
import 'package:hydhome/base/provider/view_state_model.dart';

class ReqCallBack {

  Function(List<dynamic> list) onListSuccess;
  Function(Map<String,dynamic> map) onSuccess;
  Function onError;
  Function(int code) onFailed;
  VoidCallback onCompleted;
  ViewStateModel _viewStateModel;


  ViewStateModel get viewStateModel => _viewStateModel;

  ReqCallBack setViewModel(ViewStateModel value) {
    _viewStateModel = value;
    return this;
  }

  bool isToast = true;

  String key = "records";

  bool isList = false;

  ReqCallBack({
    this.onListSuccess,
    this.onSuccess,
    this.onError,
    this.onFailed,
    this.onCompleted,
    this.isToast: true,
    this.key: "records",
    this.isList: false,
  });


  void onReqError(e, stackTrace, {String message}) {
    if(e != null)
      debugPrint('error--->\n' + e.toString());
    if(stackTrace != null)
      debugPrint('statck--->\n' + stackTrace.toString());
    if(null != onError)
      onError();

    _viewStateModel?.setError();
  }

  void onReqCompleted() {
    if(null != onCompleted)
      onCompleted();

  }

  void onReqFailed(int code) {
    if(null != onFailed)
      onFailed(code);

  }

  void onReqSuccess(Map<String, dynamic> map) {
    var result = map["result"];

    String str;
    if(Config.DEVELOP || Config.PRE || Config.TEST){
      str = result.toString();
    }

    if(result is List){
      if(null != onListSuccess)
        onListSuccess(result);
    }
    else{
      if(isList){
        var value = result[key];
        if(value is List) {
          if(null != onListSuccess)
            onListSuccess(value);
        }
        else{
          if(null != onSuccess)
            onSuccess(value);
        }
      }
      else{
        if(null != onSuccess)
          onSuccess(result);
      }
    }
    _viewStateModel?.setIdle();
  }




}