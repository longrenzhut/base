

import 'package:flutter/material.dart';

class PlatformUtils {

  bool isAndroid(BuildContext context){
    var isTrue = Theme.of(context).platform == TargetPlatform.android;
    return isTrue;
  }

  bool isIOS(BuildContext context){
    var isTrue = Theme.of(context).platform == TargetPlatform.iOS;
    return isTrue;
  }


}