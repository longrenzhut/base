


import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:provider/provider.dart';

import '../provider/BaseViewModel.dart';
import 'AbsPage.dart';

abstract class BasePageState<T extends StatefulWidget,K extends BaseViewModel> extends AbsPageState<T>{

  K viewModel;

  K getViewModel();


  bool autoDispose() => true;

  @override
  Widget getContentWidget(BuildContext context) {


    var changeNotifierWidget = viewModel != null ? ChangeNotifierProvider<K>.value(
      value: viewModel,
      child: Consumer<K>(
        builder: (context,model,child){

          return super.getContentWidget(context);
        },
      ),
    ):  super.getContentWidget(context);

    return changeNotifierWidget;
  }



  @override
  void dispose() {
    if(autoDispose())
      viewModel?.dispose();
    super.dispose();
  }

}


abstract class LifecyclePageState<T extends StatefulWidget,K extends BaseViewModel> extends BasePageState<T,K> with LifecycleAware, LifecycleMixin{

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    // print("------ Login  event ${event.toString()}");
    switch(event){
      case LifecycleEvent.push://第一次跳转界面调用
        onResume();
        break;
      case LifecycleEvent.visible:
        break;
      case LifecycleEvent.active://home 后再打开页面 active
        onResume();
        break;
      case LifecycleEvent.inactive: //home 键  先调用 inactive - > invisible
        break;
      case LifecycleEvent.invisible:
        onPause();
        break;
      case LifecycleEvent.pop:
        break;
    }
  }

  void onResume();

  void onPause();

}

