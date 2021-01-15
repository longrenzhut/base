

import 'package:flutter/material.dart';
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


  const PtrListWidget({Key key,
    this.padding,
    this.itemExtent,
    this.viewModel,
    this.adapter,
    this.enablePullUp:true
  }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return PtrWidget(
      enablePullUp: enablePullUp,
      controller: viewModel.refreshController,
      onRefresh: viewModel.refresh,
      onLoading: viewModel.loadMore,
      builder: (context){
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


