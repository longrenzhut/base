
import 'package:flutter/material.dart';
import 'package:hydhome/ui/login/viewmodel/LoginVM.dart';
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
    return Container();
  }
}

