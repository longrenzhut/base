

import 'package:flutter/material.dart';
import '../../provider/StateWidget.dart';
import '../../provider/ListViewModel.dart';
import 'PtrWidget.dart';

import '../../adapter/BaseAdapter.dart';
import '../../utils/WidgetUtils.dart';

class PtrListWidget extends StatelessWidget {


  final EdgeInsetsGeometry padding;
  final bool shrinkWrap = false;
  final BaseAdapter adapter;
  final double itemExtent;
  final ListViewModel viewModel;
  final bool enablePullUp;
  final Future Function() future;
  final bool enablePullDown;
  final bool init;


  const PtrListWidget({Key key,
    this.padding,
    this.itemExtent,
    this.future,
    this.viewModel,
    this.init:true,
    this.adapter,
    this.enablePullUp:true,
    this.enablePullDown:true
  }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return PtrWidget(
      init: init,
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      controller: viewModel.refreshController,
      onRefresh: (){
       return viewModel.refresh(future);
      },
      onLoading: (){
        return viewModel.loadMore(future);
      },
      builder: (context){
        if(viewModel.list.isEmpty){
          return ViewStateEmptyWidget();
        }
        return  WidgetUtils.buildList(
            adapter: adapter,
            padding:padding,
            itemExtent: itemExtent,
            shrinkWrap: shrinkWrap
        );
      },

    );
  }
}


