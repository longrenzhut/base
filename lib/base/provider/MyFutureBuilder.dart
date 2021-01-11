import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../provider/BaseViewModel.dart';
import '../provider/StateWidget.dart';

class MyFutureBuilder<T> extends FutureBuilder<T>{

  final Future<T> future;
  final Widget Function(BuildContext context) errorBuilder;
  final Widget Function(BuildContext context) selfBuilder;
  final AsyncWidgetBuilder<T> asyncBuilder;
  final BaseViewModel model;

  MyFutureBuilder({
    Key key,
    this.future,
    this.errorBuilder,
    this.selfBuilder,
    this.asyncBuilder,
    this.model,
  }):super(
      key: key,
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!(model?.init??true)){
          return asyncBuilder(context,snapshot);
        }

        switch(snapshot.connectionState){
          case ConnectionState.none:
            return ViewStateEmptyWidget();
          case ConnectionState.waiting:
            return ViewStateBusyWidget();
          case ConnectionState.done:{
            if(snapshot.hasError){
              return errorBuilder??ViewStateErrorWidget(
                onPressed: (){
                  model?.notifyWidget();
                },
              );
            }
            else{
              if(snapshot.data != 1){
                return selfBuilder??ViewStateErrorWidget(
                  onPressed: (){
                    model?.notifyWidget();
                  },
                );
              }
              model?.init = false;
              return asyncBuilder(context,snapshot);
            }
          }
        }
        return ViewStateEmptyWidget();
      }
  );
}
