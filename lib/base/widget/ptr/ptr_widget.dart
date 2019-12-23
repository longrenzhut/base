

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PtrWidget {


  static SmartRefresher build({Widget child,
    RefreshController controller,
    bool enablePullDown: true,
    VoidCallback onRefresh,
    VoidCallback onLoading,
    bool enablePullUp: true,
  }){

    return SmartRefresher(
      header: WaterDropHeader(),
      footer: ClassicFooter(),
      onRefresh: onRefresh,
      onLoading: onLoading,
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      child: child,
      controller: controller,
    );
  }

}