import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../rxbus/rx.dart';
import '../http/HttpsProvider.dart';

import '../http/Params.dart';
import '../http/ReqCallBack.dart';

class BaseViewModel with ChangeNotifier{


  List<CancelToken> list = [];

  //当前表的总条数
  int total = 0;

  int index = 0;

  void setIndex(int index){
    this.index = index;
    notifyListeners();
  }

  bool init = false;

  bool _disposed = false;

  Future<dynamic> postP(String url,Params params,ReqCallBack reqCallBack) {
    var cancelToken = CancelToken();
    list.add(cancelToken);
    return  HttpUtils.instance().postP(url, params,cancelToken: cancelToken,callBack: reqCallBack);
  }

  Future<dynamic> postJ(String url,Params params,ReqCallBack reqCallBack) {
    var cancelToken = CancelToken();
    list.add(cancelToken);
    return  HttpUtils.instance().postJ(url, params,cancelToken: cancelToken,callBack: reqCallBack);
  }

  Future<dynamic> getP(String url,Params params,ReqCallBack reqCallBack) {
    var cancelToken = CancelToken();
    list.add(cancelToken);
    return   HttpUtils.instance().getP(url, params,cancelToken: cancelToken,callBack: reqCallBack);
  }

  Future<dynamic> getJ(String url,Params params,ReqCallBack reqCallBack) {
    var cancelToken = CancelToken();
    list.add(cancelToken);
    return  HttpUtils.instance().getJ(url, params,cancelToken: cancelToken,callBack: reqCallBack);
  }



  void notifyWidget(){
    notifyListeners();
  }


  //通信
  List<int> tagList;

  void register<T>(int tag,Function(T data) dataCallback){
    if(null == tagList)
      tagList = [];
    if(!tagList.contains(tag))
      tagList.add(tag);
    RxBus.singleton.register<T>(tag).listen((value) {
      dataCallback?.call(value.data);
    });
  }

  void post<T>(int tag,T data){
    RxBus.singleton.post<T>(tag, data);
  }


  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    RxBus.singleton.dispose(tagList);
    tagList?.clear();

    list?.forEach((element) {
      element?.cancel();
    });
    list.clear();
    list = null;
    _disposed = true;
//    debugPrint('view_state_model dispose -->$runtimeType');
    super.dispose();
  }



}

/// [e]为错误类型 :可能为 Error , Exception ,String
/// [s]为堆栈信息
printErrorStack(e, s) {
}
