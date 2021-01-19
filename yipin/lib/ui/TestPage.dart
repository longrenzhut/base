import '../base/extension/WidgetExt.dart';
import '../base/extension/ListExt.dart';

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
          padding: EdgeInsets.all(20.0),
            child: Text("头部").buildInkWell(() => showBottomSheet(
                context: context,
                builder: (context) {
                  return Container(height: 200, color: Colors.lightBlue);
                }))
        ),
        WidgetUtils.buildSliverPadding(
          padding: EdgeInsets.all(20.0),
            child: Text("头部").buildInkWell(() => showBottomSheet(
                context: context,
                backgroundColor: Colors.lightGreenAccent,
                elevation:20,
                shape: CircleBorder(),
                builder: (context) {
                  return Container(height: 200);
                }))
        ),
        WidgetUtils.buildSliverPadding(
          padding: EdgeInsets.all(20.0),
            child: Text("头部").buildInkWell(() => showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return BottomSheet(
                      onClosing:(){
                      },
                      builder:(context){
                        return Text("1111");
                      }
                  );
                }))
        ),
        WidgetUtils.buildSliverPadding(
          padding: EdgeInsets.all(20.0),
            child: Text("头部").buildInkWell(() => showModalBottomSheet(
                context: context,
                isScrollControlled: false,
                builder: (BuildContext context) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('老孟$index'),
                      );
                    },
                    itemExtent: 50,
                    itemCount: 10,
                  );
                }))
        ),
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

