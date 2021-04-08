
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../base/base/adapter/BaseAdapter.dart';
import '../../../base/base/common/PtrSliverListWidget.dart';
import '../../../base/base/page/BasePage.dart';

import '../../../base/router/RouterHelper.dart';
import '../../../base/router/routes.dart';
import '../../../base/utils/WidgetUtils.dart';
import '../../../ui/login/viewmodel/LoginVM.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage,LoginVM> {

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
                  RouterHelper.build(context, RouteSettings(name: Routes.test));
                }),
                InkWell(child: Text("头部"),onTap: (){
                  RouterHelper.build(context, RouteSettings(name: Routes.main));
                }),
              ],
            )
        )
      ],
      viewModel: viewModel,
      future: viewModel.loadData,
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

