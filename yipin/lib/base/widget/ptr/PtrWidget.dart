
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yipin/base/adapter/BaseAdapter.dart';
import 'package:yipin/base/utils/WidgetUtils.dart';

class PtrWidget extends StatelessWidget {

  final PtrController controller;

  final Function() onRefresh;

  final VoidCallback onLoading;
  final EdgeInsetsGeometry padding;
  final bool shrinkWrap = false;
  final BaseAdapter adapter;


  const PtrWidget({Key key, this.controller, this.onRefresh, this.onLoading,
    this.padding,
    this.adapter}
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: controller,
      onRefresh: (){
        controller.page = 0;
        onRefresh();
      },
      onLoading: (){
        if(controller.footerStatus != LoadStatus.failed){
          controller.page++;
        }
        onLoading();
      },
      child: WidgetUtils.buildList(
          adapter: adapter,
          padding:padding,
          shrinkWrap: shrinkWrap
      ),

    );
  }
}

class PtrController extends RefreshController{

  PtrController({bool initialRefresh: false}):super(initialRefresh: initialRefresh);

  int page = 0;


}
