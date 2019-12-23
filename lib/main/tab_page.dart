

import 'package:flutter/material.dart';
import 'package:hydhome/base/adapter/BasePvAdapter.dart';
import 'package:hydhome/base/common/BaseNoPage.dart';
import 'package:hydhome/base/provider/provider_widget.dart';
import 'package:hydhome/base/widget/list/GridViewZ.dart';
import 'package:hydhome/base/widget/list/PageViewZ.dart';
import 'package:hydhome/main/adapter/MyTabAdapter.dart';
import 'package:hydhome/main/view_model/TabModel.dart';


class TabPage extends BaseNoPage {

  PageController _pageController;

  @override
  Widget getContentWidget(BuildContext context) {
    _pageController = PageController();
    return HomePage(pageController: _pageController,);
  }

  @override
  Widget getbottomNavigationBar(BuildContext context) {
    return ProviderWidget2<TabModel,MyTabAdapter>(
        onModelReady: (model,adapter){
          model.setType(null);
          adapter.setOnItemCallback((index,model){
            if(adapter.position == index)
              return;
            adapter.position = index;
            adapter.notifyListeners();

            _pageController.jumpToPage(index);
          });
        },
        model1: TabModel(),
        model2: MyTabAdapter(),
        builder: (context, model,adapter,child){
          adapter.setDatas(model.tablist);
          return GridViewZ.build(adapter);
        }
    );
  }
}

class HomePage extends StatefulWidget {
  PageController pageController;

  HomePage({this.pageController});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return ProviderWidget<TabModel>(
        onModelReady: (model){
          model.setType(null);
        },
        model: TabModel(),
        builder: (context, model,child){
          var _contentAdapter = BasePvAdapter();
          _contentAdapter.setDatas(model.contentlist);
          return PageViewZ.build(_contentAdapter,
              controller: widget.pageController,
              physics: const NeverScrollableScrollPhysics()
          );
        }
    );
  }
}










