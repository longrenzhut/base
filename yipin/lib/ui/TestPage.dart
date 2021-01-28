import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:yipin/base/utils/ToastUtil.dart';
import 'package:yipin/base/widget/tab/TabBarWidget.dart';
import 'package:yipin/base/widget/tab/TabPageWidget.dart';
import 'package:yipin/ui/login/page/LoginPage.dart';
import 'package:yipin/ui/main/page/MainPage.dart';
import '../base/router/routes.dart';
import '../base/router/RouterHelper.dart';

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

  int get type => arguments["type"]??0;

  @override
  Widget getView(BuildContext context) {
    if(type == 1)
      return _tabWidget();
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
                        isFirst = !isFirst;
                        viewModel.notifyUI();
                        ToastUtil.showToast("$type");
                      // viewModel.notifyUI();
                    }),
              ],
            )
        ),
        WidgetUtils.buildSliverPadding(
          padding: EdgeInsets.all(20.0),
            child: Text("头部").buildInkWell(() =>
              RouterHelper.build(context, RouteSettings(name: Routes.test,arguments: {"type": 1}))
                // showBottomSheet(
                // context: context,
                // backgroundColor: Colors.lightGreenAccent,
                // elevation:20,
                // shape: CircleBorder(),
                // builder: (context) {
                //   return Container(height: 200);
                // })
            )
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
            child: Text("头部11").buildInkWell(() =>  RouterHelper.build(context, RouteSettings(name: Routes.login)))
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


  _tabWidget(){
    return TabPageWidget(
      tabTitles: [
        "11111","22222"
      ],
      pages: [
        LoginPage(),
        MainPage(),
      ],
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

