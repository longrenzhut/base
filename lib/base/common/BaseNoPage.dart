

import 'package:flutter/material.dart';
import 'package:hydhome/base/common/BasePage.dart';

abstract class BaseNoPage extends BasePage{

  @override
  bool isUserHeader(){
    return false;
  }

  @override
  bool isUserstatusBar(){
    return false;
  }

  @override
  void initWidget(BuildContext context) {
  }

}