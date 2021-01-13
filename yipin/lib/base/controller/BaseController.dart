
import '../utils/BaseUtils.dart';

mixin BaseController {


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

}
