

import 'package:flutter/material.dart';
import '../provider/BaseViewModel.dart';

import '../provider/provider_widget.dart';

class MyPageView extends StatelessWidget {

  final MyPageViewController controller;
  final List<Widget> children;

  const MyPageView({Key key,
    @required this.controller,
    @required this.children
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var _controller = controller??MyPageViewController();
    return ProviderWidget(
        builder: (context,model,child){
          return children[model.index];
        },
        model: _controller);
  }
}

class MyPageViewController extends BaseViewModel {


  int index = 0;

  void setIndex(int index) {
    this.index = index;
    notifyWidget();
  }
}

