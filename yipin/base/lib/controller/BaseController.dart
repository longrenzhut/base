
import 'package:base/utils/BaseUtils.dart';

mixin BaseController{


  int index = 0;

  void setIndex(int index,{bool isNotify: true}){
    this.index = index;
    if(isNotify)
    _notifyWidget?.call();
  }

  Function() _notifyWidget;

  void setNotifyWidget(Function() _notifyWidget){
    this._notifyWidget = _notifyWidget;
  }

  void notifyUI(){
    _notifyWidget?.call();
  }


  String _value;

  String get value => _value;

  void setValue(String value) {
    _value = value;
  }

  void reset(){
    _value = null;
  }

  bool isEmpty(){
    return BaseUtils.isEmpty(value);
  }

  void dispose(){
    _notifyWidget = null;
  }

}
