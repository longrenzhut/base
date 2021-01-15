
import 'package:flutter/material.dart';
import '../../provider/StateWidget.dart';
import '../../provider/ListViewModel.dart';
import 'PtrWidget.dart';

import '../../adapter/BaseAdapter.dart';
import '../../utils/WidgetUtils.dart';


class PtrSliverListWidget extends StatelessWidget {

  final EdgeInsetsGeometry padding;
  final bool shrinkWrap = false;
  final BaseAdapter adapter;
  final double itemExtent;
  final ListViewModel viewModel;
  final bool enablePullUp;
  final List<Widget> slivers;


  const PtrSliverListWidget({Key key,
    this.padding,
    this.itemExtent,
    this.viewModel,
    this.adapter,
    this.slivers,
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
        if(viewModel.list.isEmpty){
          return ViewStateEmptyWidget();
        }
        return CustomScrollView(
          slivers: List.generate((slivers?.length??0) + 1, (index){
            if(index == (slivers?.length??0))
              return child;
            return slivers[index];
          }).toList(),
        );
      },

    );
  }

  Widget get child{
    if(null == itemExtent){
      return WidgetUtils.buildSliverList(
          adapter: adapter
      );
    }
    return WidgetUtils.buildSliverExtentList(
        itemExtent: itemExtent,
        adapter: adapter
    );
  }
}
