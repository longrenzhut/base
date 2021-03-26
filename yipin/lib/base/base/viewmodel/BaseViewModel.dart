import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../base/common/PtrWidget.dart';
import '../../base/common/StateWidget.dart';
import 'ViewModelMixin.dart';

class BaseViewModel with ChangeNotifier,ViewModelMixin{

  PtrController _ptrController;

  PtrController get ptrController {
    if(null == _ptrController)
      _ptrController = PtrController(initialRefresh: false);
    return _ptrController;
  }

  RefreshController _refreshController;

  RefreshController get refreshController {
    if(null == _refreshController)
      _refreshController = ptrController.refreshCtr;
    return _refreshController;
  }



  Function() _notifyWidget;

  void setNotifyWidget(Function() _notifyWidget){
    this._notifyWidget = _notifyWidget;
  }

  void notifyState(){
    _notifyWidget?.call();
  }


  bool _disposed = false;

  bool requestTrue = true;

  void notifyUI(){
    if (!_disposed) {
      requestTrue = true;
      notifyListeners();
    }
  }



  @override
  void dispose() {
    _notifyWidget = null;
    _disposed = true;
    super.dispose();
  }


  Widget get selfWidget => null;
  Widget get errorWidget => null;

  Widget stateWidget({VoidCallback onPressed,int state}){

    return StateWidget(
      selfBuilder:(context)=> selfWidget,
      errorBuilder: (context) => errorWidget,
      state: state,
      onPressed: (){
        if(null != onPressed)
          onPressed.call();
        else
          notifyUI();
      },
    );
  }


}

