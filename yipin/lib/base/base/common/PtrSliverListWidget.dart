


import 'package:flutter/material.dart';
import '../../base/common/StateWidget.dart';
import '../../base/adapter/BaseAdapter.dart';
import '../../base/viewmodel/ListViewModel.dart';
import 'PtrWidget.dart';

import '../../utils/WidgetUtils.dart';

class PtrSliverListWidget extends PtrWidget<ListViewModel> {

  final EdgeInsetsGeometry padding;
  final BaseAdapter adapter;
  final double itemExtent;
  final ListViewModel viewModel;
  final bool enablePullUp;
  final List<Widget> slivers;
  final Future Function() future;
  final bool initFuture;


  PtrSliverListWidget({Key key,
    this.initFuture:true,
    this.padding,
    this.itemExtent,
    this.viewModel,
    this.adapter,
    this.slivers,
    this.enablePullUp:true,
    this.future,
  }) : super(key: key,
    initFuture: initFuture,
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
      return CustomScrollView(
        slivers: [
          ...slivers,
          WidgetUtils.buildSliverList(
              itemExtent: itemExtent,
              adapter: adapter
          )
        ],
      );
    },

  );

}

