

import 'package:hydhome/base/provider/view_state_model.dart';

class HeaderModel extends ViewStateModel{

   String _title;
   String _rightText;
   bool _isLeft;

   String get title => _title;

   set title(String value) {
     if(value == _title)
       return;
     _title = value;

     notifyListeners();
   }

   String get rightText => _rightText;

   set rightText(String value) {
     if(value == _rightText)
       return;
     _rightText = value;

     notifyListeners();
   }

   bool get isLeft => _isLeft;

   set isLeft(bool value) {
     if(value == isLeft)
       return;
     _isLeft = value;

     notifyListeners();
   }


}