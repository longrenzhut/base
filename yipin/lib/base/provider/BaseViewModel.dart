import 'package:flutter/material.dart';
import '../provider/ViewModelMixin.dart';

class BaseViewModel with ChangeNotifier,ViewModelMixin{



  bool init = true;

  bool _disposed = false;



  void notifyUI(){
    if (!_disposed) {
      notifyListeners();
    }
  }



  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }


}

