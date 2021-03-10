
import 'package:flutter/material.dart';
import '../rxbus/rx.dart';
import '../view/BaseMixin.dart';

abstract class AbsPageState<T extends StatefulWidget> extends State<T> with BaseMixin ,AutomaticKeepAliveClientMixin{

  var isInit = true;

  void initValue(){
  }

  Color get bgColor => null;

  bool get isScaffold => true;

  bool get isUseHeader =>true;


  Map get arguments => argumentOf(context);

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget getAppBar(BuildContext context) {
    if(!isUseHeader)
      return null;

    return null;
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
  Widget build(BuildContext context) {
    if(isInit) {
      initValue();
      isInit = false;
    }
    return getContentWidget(context);
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
    super.dispose();
  }

}


