import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hydhome/base/provider/BaseViewModel.dart';
import '../provider/view_state_widget.dart';

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
        if(!(model?.isFirst??true)){
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
//              if(model?.error??false){
//                return errorBuilder??ViewStateErrorWidget(
//                  onPressed: (){
//                    model?.notifyWidget();
//                  },
//                );
//              }
//              else if(model?.failed??false){
//                return selfBuilder??ViewStateErrorWidget(
//                  onPressed: (){
//                    model?.notifyWidget();
//                  },
//                );
//              }
              if(snapshot.data != 1){
                return selfBuilder??ViewStateErrorWidget(
                  onPressed: (){
                    model?.notifyWidget();
                  },
                );
              }
              model?.isFirst = false;
              return asyncBuilder(context,snapshot);
            }
          }
        }
        return ViewStateEmptyWidget();
      }
  );
}
