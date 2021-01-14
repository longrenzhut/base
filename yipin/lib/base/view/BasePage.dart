


import 'package:flutter/material.dart';
import '../provider/BaseViewModel.dart';
import 'package:provider/provider.dart';

import '../utils/MyColors.dart';
import '../view/BaseMixin.dart';


abstract class BasePageState<T extends StatefulWidget,K extends BaseViewModel> extends State<T> with BaseMixin ,AutomaticKeepAliveClientMixin{


  K viewModel;

//  @override
  Color get bgColor => null;

  bool autoDispose(){
    return true;
  }


  @override
  void initState() {
    viewModel = getViewModel();
//    print(viewModel.toString());
    super.initState();
  }



  Map get arguments {
    Map map = argumentOf(context);
    return map;
  }



  @override
  Widget build(BuildContext context) {

    var _provider = viewModel != null ? ChangeNotifierProvider<K>.value(
      value: viewModel,
      child: Consumer<K>(
        builder: (context,model,child){
          return getView(context);
        },
      ),
    ): getView(context);




    return Scaffold(
        appBar: getAppBar(context),
        backgroundColor: bgColor,
        body: _provider
    );
  }


  @override
  void dispose() {
    if(autoDispose())
      viewModel?.dispose();
    super.dispose();
  }


  K getViewModel();





  @override
  Widget getAppBar(BuildContext context) {
    return null;
  }


  @override
  bool get wantKeepAlive => false;


  void registerRxBus<T>(int tag,Function(T data) dataCallback){
    viewModel?.register<T>(tag,dataCallback);
  }

  void sendMessage<T>(int tag,T data){
    viewModel?.post<T>(tag,data);
  }
}



