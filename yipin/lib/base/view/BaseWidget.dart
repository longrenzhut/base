
import 'package:flutter/material.dart';
import '../provider/ViewModelMixin.dart';

import '../controller/BaseController.dart';



abstract class BaseWidgetState<T extends StatefulWidget,K extends BaseWidgetController> extends State<T>  with AutomaticKeepAliveClientMixin{


  K controller;

  bool autoDispose(){
    return true;
  }


  @override
  void initState() {
    controller = getController();
    controller.setNotifyWidget((){
      if(mounted)
        setState(() {
        });
    });
    super.initState();
  }


  @override
  void dispose() {
    if(autoDispose())
      controller?.dispose();
    super.dispose();
  }


  K getController();



  @override
  bool get wantKeepAlive => false;


  void registerRxBus<T>(int tag,Function(T data) dataCallback){
    controller?.registerRxBus<T>(tag,dataCallback);
  }

  void sendMessage<T>(int tag,T data){
    controller?.sendMessage<T>(tag,data);
  }
}

class BaseWidgetController with BaseController,ViewModelMixin{




  @override
  void dispose() {
    cancel();
    super.dispose();
  }
}





