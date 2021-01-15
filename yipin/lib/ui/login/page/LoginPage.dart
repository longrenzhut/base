
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yipin/base/adapter/BaseAdapter.dart';
import 'package:yipin/base/utils/WidgetUtils.dart';
import 'package:yipin/base/widget/ptr/PtrListWidget.dart';
import 'package:yipin/base/widget/ptr/PtrWidget.dart';
import 'package:yipin/ui/login/viewmodel/LoginVM.dart';

import '../../../base/view/BasePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage,LoginVM> {

  @override
  LoginVM getViewModel() =>  LoginVM();


  @override
  Widget getView(BuildContext context) {
    return PtrListWidget(
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

