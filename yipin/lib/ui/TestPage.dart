import '../base/adapter/BaseAdapter.dart';

import '../base/utils/WidgetUtils.dart';


import 'package:flutter/material.dart';
import '../base/widget/ptr/PtrSliverListWidget.dart';
import 'TestVM.dart';
import '../base/view/BasePage.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends BasePageState<TestPage,TestVM> {
  
  @override
  TestVM getViewModel() =>  TestVM();
  
  @override
  Widget getView(BuildContext context) {
    return PtrSliverListWidget(
      slivers: [
        WidgetUtils.buildSliverPadding(
            child: Text("头部")
        )
      ],
      viewModel: viewModel,
      itemExtent: 100,
      adapter: BaseAdapter<String>(
          data: viewModel.list,
          builder: (context,index,model){
            return Card(child: Text(model),);
          }
      ),

    );
  }
}

