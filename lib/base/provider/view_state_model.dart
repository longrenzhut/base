import 'package:flutter/material.dart';
import 'package:hydhome/base/http/HttpProvider.dart';
import 'package:hydhome/base/http/Params.dart';
import 'package:hydhome/base/http/ReqCallBack.dart';

import 'view_state.dart';
import 'view_state_widget.dart';

class ViewStateModel with ChangeNotifier {
  bool _disposed = false;

  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
  ViewState _viewState;

  ViewStateModel({ViewState viewState})
      : _viewState = viewState ?? ViewState.idle {
    debugPrint('BaseNotifier---constructor--->$runtimeType');
  }

  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewStateError = null;
    _viewState = viewState;
    notifyListeners();
    debugPrint('BaseNotifier---constructor--->"调用notifyListeners"--->${viewState.toString()}');
  }

  ViewStateError _viewStateError;

  ViewStateError get viewStateError => _viewStateError;

  String get errorMessage => _viewStateError?.message;


  bool get busy => viewState == ViewState.busy;

  bool get idle => viewState == ViewState.idle;

  bool get empty => viewState == ViewState.empty;

  bool get error => viewState == ViewState.error;

  bool get unAuthorized => viewState == ViewState.unAuthorized;

  void setIdle() {
    viewState = ViewState.idle;
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  void setError() {
    viewState = ViewState.error;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  void setUnAuthorized() {
    viewState = ViewState.unAuthorized;
    onUnAuthorizedException();
  }


  Future requestP(String url,
      Params param
      ) {
    return  HttpProvider.getInstance().postP(url, param, null);
  }


  void postP(String url,Params params,ReqCallBack reqCallBack){
    HttpProvider.getInstance().postP(url, params, reqCallBack);
  }

  void postJ(String url,Params params,ReqCallBack reqCallBack){
    HttpProvider.getInstance().postJ(url, params,reqCallBack);
  }


  void zip(List<Future> list,List<ReqCallBack> callbacks){
    HttpProvider.getInstance().zipPost(list, callbacks);
  }

  /// 未授权的回调
  void onUnAuthorizedException() {}


  @override
  String toString() {
    return 'BaseModel{_viewState: $viewState, _viewStateError: $_viewStateError}';
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    debugPrint('view_state_model dispose -->$runtimeType');
    super.dispose();
  }

  //是否第一次进入界面
  bool _isInit = true;


  bool get isInit => _isInit;

  set isInit(bool value) {
    _isInit = value;
  }

  void initData(){

  }

  Widget builder({Widget child}){
    debugPrint("刷新界面--->" + viewState?.toString());
    if(!isInit){
      return child;
    }

    if (busy) {
      return ViewStateBusyWidget();
    }
    else if (error) {
      return ViewStateErrorWidget(onPressed: (){
        initData();
      },);
    }
    else if (empty) {
      return ViewStateEmptyWidget();
    }
    else if (unAuthorized) {
      return ViewStateUnAuthWidget();
    }
    //model.idle

    return child;
  }

}

/// [e]为错误类型 :可能为 Error , Exception ,String
/// [s]为堆栈信息
printErrorStack(e, s) {
}
