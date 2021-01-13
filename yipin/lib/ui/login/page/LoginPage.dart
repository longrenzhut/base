
import 'package:flutter/material.dart';
import 'package:yipin/base/widget/TextView.dart';
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
    return SafeArea(child: TextView("dsfsdfsdf"));
  }
}

