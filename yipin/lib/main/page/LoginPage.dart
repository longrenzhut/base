
import 'package:base/base/adapter/BaseAdapter.dart';
import 'package:base/base/common/PtrSliverListWidget.dart';
import 'package:base/base/page/BasePage.dart';
import 'package:base/utils/WidgetUtils.dart';
import 'package:flutter/material.dart';
import 'package:yipin/common/router/MyRouter.dart';
import 'package:yipin/main/viewmodel/LoginVM.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage, LoginVM> {

  @override
  LoginVM getViewModel() =>  LoginVM();



  @override
  Widget getView(BuildContext context) {

    return PtrSliverListWidget(
      slivers: [
        WidgetUtils.buildSliverPadding(
            child: Column(
              children: [
                SizedBox(height: 30,),
                InkWell(child: Text("头部"),onTap: (){
                  MyRouter.buildTest(context);
                }),
                InkWell(child: Text("头部"),onTap: (){
                  MyRouter.buildMain(context);
                }),
              ],
            )
        )
      ],
      viewModel: viewModel,
      future: ()=>viewModel.loadData(),
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
  bool get wantKeepAlive => true;

}


