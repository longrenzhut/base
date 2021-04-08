

import 'package:flutter/material.dart';
import 'StateWidget.dart';
import 'package:base/base/adapter/BaseAdapter.dart';
import 'package:base/base/viewmodel/ListViewModel.dart';
import 'PtrWidget.dart';

import 'package:base/utils/WidgetUtils.dart';

class PtrListWidget extends PtrWidget<ListViewModel> {


  final EdgeInsetsGeometry padding;
  final bool shrinkWrap;
  final BaseAdapter adapter;
  final double itemExtent;
  final ListViewModel viewModel;
  final bool enablePullUp;
  final Future Function() future;
  final bool enablePullDown;
  final bool initFuture;


  PtrListWidget({Key key,
    this.padding,
    this.itemExtent,
    this.future,
    this.viewModel,
    this.initFuture:true,
    this.adapter,
    this.shrinkWrap:false,
    this.enablePullUp:true,
    this.enablePullDown:true
  }) : super(key: key,
    initFuture: initFuture,
    enablePullDown: enablePullDown,
    enablePullUp: enablePullUp,
    viewModel: viewModel,
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
      return WidgetUtils.buildList(
          adapter: adapter,
          padding:padding,
          itemExtent: itemExtent,
          shrinkWrap: shrinkWrap
      );
    },

  );

}


