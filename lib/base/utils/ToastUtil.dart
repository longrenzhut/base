

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Adapt.dart';

class ToastUtil{


  static void showToast(String text){
  if(null == text || text.length == 0)
    return;
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black26,
      textColor: Colors.white,
      fontSize: Adapt.setTextSp(16)
    );

  }

}