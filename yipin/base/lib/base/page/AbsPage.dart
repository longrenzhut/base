
import 'package:base/base/common/MyAppBar.dart';
import 'package:base/router/RouterHelper.dart';
import 'package:flutter/material.dart';
import 'package:base/rxbus/rx.dart';
import 'BaseMixin.dart';

abstract class AbsPageState<T extends StatefulWidget> extends State<T> with BaseMixin ,AutomaticKeepAliveClientMixin{

  var isInit = true;

  void initValue(){
  }

  Color get bgColor => null;

  bool get isScaffold => true;

  bool get isUseHeader =>true;


  Map get arguments => argumentOf(context);


  AppBarController _controller;

  AppBarController get controller{
    if(null == _controller)
      _controller = AppBarController(leftFunc:onIvLeftClick);
    return _controller;
  }


  void onIvLeftClick(){
    RouterHelper.pop(context);
  }

  @override
  Widget getAppBar(BuildContext context) {
    if(!isUseHeader)
      return null;
    return MyAppBar(controller: controller,);
  }


  @override
  void initState() {
    super.initState();
    initPage();
  }

  void initPage(){

  }

  @override
  Widget build(BuildContext context) {
    if(isInit) {
      initValue();
      isInit = false;
    }
    return getContentWidget(context);
  }



  Widget getContentWidget(BuildContext context){

    return isScaffold ? Scaffold(
      appBar: getAppBar(context),
      backgroundColor: bgColor,
      body: getView(context),
      bottomNavigationBar: getBottomNavigationBar(context),
    ): getView(context);
  }




  @override
  bool get wantKeepAlive => false;


  //通信
  RxBusUtils rxBusUtils;

  void register<T>(int tag, Function(T data) dataCallback) {
    if (null == rxBusUtils)
      rxBusUtils = RxBusUtils();
    rxBusUtils.register<T>(tag, dataCallback);
  }

  void sendMessage<T>(int tag, T data) {
    if (null == rxBusUtils)
      rxBusUtils = RxBusUtils();
    rxBusUtils.post<T>(tag, data);
  }

  @override
  void dispose() {
    rxBusUtils?.dispose();
    _controller?.dispose();
    super.dispose();
  }

}


