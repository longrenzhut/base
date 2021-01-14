
import '../utils/BaseUtils.dart';

mixin BaseController{


  int index = 0;

  void setIndex(int index){
    this.index = index;
    notifyWidget();
  }

  Function() notifyWidget;

  void setNotifyWidget(Function() notifyWidget){
    this.notifyWidget = notifyWidget;
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
    return BaseUtils.isEmpty(_value);
  }

  void dispose(){
    notifyWidget = null;
  }

}
