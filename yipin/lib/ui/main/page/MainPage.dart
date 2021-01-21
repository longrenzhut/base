
import 'package:flutter/material.dart';
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
    return Container();
  }
}
