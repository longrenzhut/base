

import 'package:hydhome/base/adapter/BaseAdapter.dart';

abstract class BaseGvAdapter<T> extends BaseAdapter<T>{




  int getSpanCount();

  double getVerSpcing(){
    return 0.0;
  }

  double getHorSpcing(){
    return 0.0;
  }

  double getchildAspectRatio(){
    return 1.0;
  }

}