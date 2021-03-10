
import 'package:dio/dio.dart';
import '../rxbus/rx.dart';

import '../http/HttpsProvider.dart';
import '../http/Params.dart';
import '../http/ReqCallBack.dart';


mixin ViewModelMixin {

  List<CancelToken> _cancelTokenList;

  CancelToken get _cancelToken {
    var _cancelToken = CancelToken();
    if (null == _cancelTokenList)
      _cancelTokenList = [];
    _cancelTokenList.add(_cancelToken);
    return _cancelToken;
  }


  Future<dynamic> postP(String url, Params params, ReqCallBack reqCallBack) {
    return HttpUtils.instance().postP(
        url, params, cancelToken: _cancelToken, callBack: reqCallBack);
  }

  Future<dynamic> postJ(String url, Params params, ReqCallBack reqCallBack) {
    return HttpUtils.instance().postJ(
        url, params, cancelToken: _cancelToken, callBack: reqCallBack);
  }

  Future<dynamic> getP(String url, Params params, ReqCallBack reqCallBack) {
    return HttpUtils.instance().getP(
        url, params, cancelToken: _cancelToken, callBack: reqCallBack);
  }

  Future<dynamic> getJ(String url, Params params, ReqCallBack reqCallBack) {
    return HttpUtils.instance().getJ(
        url, params, cancelToken: _cancelToken, callBack: reqCallBack);
  }

  Future<dynamic> get(String url, Params params) {
    return HttpUtils.instance().get(
        url, data: params.map, token: _cancelToken);
  }

  Future<dynamic> getByMap(String url, Map<String, dynamic> map) {
    return HttpUtils.instance().get(
        url, data: map, token: _cancelToken);
  }

  Future<dynamic> postFile(String url, Params params,ReqCallBack reqCallBack) {
    return HttpUtils.instance().postFile(url,params,callBack: reqCallBack, cancelToken: _cancelToken);
  }

  //通信
  RxBusUtils rxBusUtils;


  void registerRxBus<T>(int tag, Function(T data) dataCallback) {
    if (null == rxBusUtils)
      rxBusUtils = RxBusUtils();
    rxBusUtils.register<T>(tag, dataCallback);
  }

  void sendMessage<T>(int tag, T data) {
    if (null == rxBusUtils)
      rxBusUtils = RxBusUtils();
    rxBusUtils.post<T>(tag, data);
  }


  void cancel(){
    rxBusUtils?.dispose();

    _cancelTokenList?.forEach((element) {
      element?.cancel();
    });
    _cancelTokenList?.clear();
    _cancelTokenList = null;
  }
}
