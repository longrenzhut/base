import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';

import '../base/adapter/BaseAdapter.dart';
import '../base/extension/WidgetExt.dart';
import '../base/utils/ImageHelper.dart';
import '../base/utils/WidgetUtils.dart';
import '../base/view/BasePage.dart';
import '../base/widget/AnimWidget.dart';
import '../base/widget/ptr/PtrSliverListWidget.dart';
import 'TestVM.dart';


class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends LifecyclePageState<TestPage,TestVM> {
  
  @override
  TestVM getViewModel() =>  TestVM();

  bool isFirst = true;

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
            child: Column(
              children: [
                AnimWidget(),
                InkWell(child:
                AnimatedCrossFade(
                  duration: Duration(seconds: 1),
                  crossFadeState: isFirst? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  firstChild:  ImageHelper.buildImage("ic_home.png",width: 20,height: 20,type: 1,fit: BoxFit.fitHeight),
                  secondChild:  ImageHelper.buildImage("ic_home_selector.png",width: 20,height: 20,type: 1,fit: BoxFit.fitHeight),
                ),
                    onTap: (){
                      setState(() {
                        isFirst = !isFirst;
                      });
                      // viewModel.notifyUI();
                    }),
              ],
            )
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
        WidgetUtils.buildSliverPadding(
          padding: EdgeInsets.all(20.0),
            child: Text("头部11").buildInkWell(() => OpenSettings.openDateSetting())
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

  @override
  void onPause() {
    print("---- test onPause");
  }

  @override
  void onResume() {
    print("---- test onResume");
  }
}

