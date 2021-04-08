
import 'package:base/base/page/BasePage.dart';
import 'package:base/widget/MyIndexStack.dart';
import 'package:base/widget/tab/BottomBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:yipin/main/viewmodel/MainVM.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends BasePageState<MainPage,MainVM> {

  @override
  MainVM getViewModel() =>  MainVM();

  @override
  Widget getView(BuildContext context) {
    return MyIndexStack(
        controller: viewModel.indexStackController,
        children: [
          Text("111"),
          Text("222"),
          Text("333"),
          Text("444"),
        ]
    );
  }

  @override
  Widget getBottomNavigationBar(BuildContext context) {
    return BottomBarWidget(callback: (index){
      viewModel.indexStackController.setIndex(index);
    },);
  }

  @override
  bool get wantKeepAlive => true;
}
