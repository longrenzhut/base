
import 'package:flutter/material.dart';
import '../../../base/widget/MyIndexStack.dart';
import '../../../base/widget/tab/BottomBarWidget.dart';
import '../../../base/view/BasePage.dart';
import '../../../base/extension/WidgetExt.dart';
import '../../../base/extension/ListExt.dart';
import '../../../ui/main/viewmodel/MainVM.dart';

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
}
