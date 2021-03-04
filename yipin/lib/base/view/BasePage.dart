


import '../../base/router/RouterHelper.dart';
import '../../base/utils/ImageHelper.dart';
import '../../base/utils/LaunchUtils.dart';
import '../../base/widget/TextView.dart';
import '../../common/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import '../provider/BaseViewModel.dart';
import 'package:provider/provider.dart';

import '../utils/CstColors.dart';
import '../view/BaseMixin.dart';
import '../../base/extension/WidgetExt.dart';

abstract class BasePageState<T extends StatefulWidget,K extends BaseViewModel> extends State<T> with BaseMixin ,AutomaticKeepAliveClientMixin{


  K viewModel;

//  @override
  Color get bgColor => null;
  bool get isScaffold => true;

  bool autoDispose(){
    return true;
  }


  @override
  void initState() {
    viewModel = getViewModel();
    super.initState();
  }


  Map get arguments => argumentOf(context);


  var isInit = true;

  void initValue(){
  }


  @override
  Widget build(BuildContext context) {
    if(isInit) {
      initValue();
      isInit = false;
    }

    var _provider = viewModel != null ? ChangeNotifierProvider<K>.value(
      value: viewModel,
      child: Consumer<K>(
        builder: (context,model,child){
          return getView(context);
        },
      ),
    ):  getView(context);


    if(!isScaffold)
      return _provider;

    return Scaffold(
      appBar: getAppBar(context),
      backgroundColor: bgColor,
      body: _provider,
      bottomNavigationBar: getBottomNavigationBar(context),
    );
  }


  @override
  void dispose() {
    if(autoDispose())
      viewModel?.dispose();
    super.dispose();
  }


  K getViewModel();



  Widget getAppBar(BuildContext context) {
    return null;
  }


  @override
  Widget getBottomNavigationBar(BuildContext context) {
    return null;
  }


  @override
  bool get wantKeepAlive => false;


  void registerRxBus<T>(int tag,Function(T data) dataCallback){
    viewModel?.register<T>(tag,dataCallback);
  }

  void sendMessage<T>(int tag,T data){
    viewModel?.sendMessage<T>(tag,data);
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

