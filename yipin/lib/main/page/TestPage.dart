import 'package:accessibility/accessibility.dart';
import 'package:animate_do/animate_do.dart';
import 'package:base/base/adapter/BaseAdapter.dart';
import 'package:base/base/common/PtrSliverListWidget.dart';
import 'package:base/base/page/BasePage.dart';
import 'package:base/extension/WidgetExt.dart';
import 'package:base/utils/ImageHelper.dart';
import 'package:base/utils/ToastUtil.dart';
import 'package:base/utils/WidgetUtils.dart';
import 'package:base/widget/AnimWidget.dart';
import 'package:base/widget/TextView.dart';
import 'package:base/widget/tab/TabPageWidget.dart';
import 'package:flutter/material.dart';
import 'package:yipin/common/router/MyRouter.dart';
import 'package:yipin/main/page/LoginPage.dart';
import 'package:yipin/main/page/MainPage.dart';
import 'package:yipin/main/viewmodel/TestVM.dart';




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
  void initState() {
    super.initState();
    controller.setTitle("测试",children:[
      TextView("测试")
    ] );
  }

  @override
  Widget getView(BuildContext context) {
    if(type == 1)
      return _tabWidget();
    else if(type == 2)
      return Center(
        child: Container(
          width: 200,
          height: 200,
        ),
      );
    return PtrSliverListWidget(
      slivers: [
        WidgetUtils.buildSliverPadding(
            padding: EdgeInsets.all(20.0),
            child: Text("charts").buildInkWell(() {
              Accessibility.repeatPicByWx(4);
            }
            )
        ),
        WidgetUtils.buildSliverPadding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                FadeInLeft(
                    delay: Duration(milliseconds: 1000),
                    child: Container(height: 30, width:30,color: Colors.lightBlue) ),
                FadeInUp(  delay: Duration(milliseconds: 1000),child: Container(height: 30, width:30, color: Colors.lightBlue) ),
                FadeInDown(  delay: Duration(milliseconds: 1000),child: Container(height: 30,  width:30,color: Colors.lightBlue) ),
              ],
            )
        ),
        WidgetUtils.buildSliverPadding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                BounceInDown(child: Container(height: 30,  width:30,color: Colors.lightBlue) ),
                BounceInUp(child: Container(height: 30,  width:30,color: Colors.lightBlue) ),
                BounceInLeft(child: Container(height: 30,  width:30,color: Colors.lightBlue) ),
                BounceInRight(child: Container(height: 30,  width:30,color: Colors.lightBlue) ),
              ],
            )
        ),
        WidgetUtils.buildSliverPadding(
            child: Column(
              children: <Widget>[
                SlideInDown(child: Container(height: 30,  width:double.infinity,color: Colors.lightBlue) ),
                SlideInUp(child: Container(height: 30,  width:double.infinity,color: Colors.lightBlue) ),
                SlideInLeft(child: Container(height: 30,  width:double.infinity,color: Colors.lightBlue) ),
                SlideInRight(child: Container(height: 30,  width:30,color: Colors.lightBlue) ),
              ],
            )
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
                MyRouter.buildTest(context,type: 1)
              // showBottomSheet(
              // context: context,
              // backgroundColor: Colors.lightGreenAccent,
              // elevation:20,
              // shape: CircleBorder(),
              // builder: (context) {
              //   return Container(height: 30);
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
            child: Text("头部11").buildInkWell(() =>
                MyRouter.buildLogin(context)
            )
        ),
      ],
      viewModel: viewModel,
      itemExtent: 100,
      future: ()=>viewModel.loadData(),
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



