

import 'package:flutter/material.dart';
import 'package:hydhome/base/provider/view_state_model.dart';

class ScrollchangeModel extends ViewStateModel{



  Color _color;

  Color _lineColor = Colors.white;


  Color get lineColor => _lineColor;


  set lineColor(Color value) {
    _lineColor = value;
  }

  Color get color => _color;

  set color(Color value) {
    if(_color == value)
      return;
    _color = value;
    notifyListeners();
  }


  String _personIcon = "person";
  String _searchIcon = "search";


  String get personIcon => _personIcon;

  set personIcon(String value) {
    _personIcon = value;
  }

  set searchIcon(String value) {
    _searchIcon = value;
  }

  String get searchIcon => _searchIcon;


}