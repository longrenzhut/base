
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:base/base/viewmodel/BaseViewModel.dart';
import '../widget/BaseWidget.dart';


class PtrWidget<T extends BaseViewModel> extends StatefulWidget {
  final bool enablePullUp;
  final bool enablePullDown;
  final bool enableTwoLevel;
  final bool initFuture;
  final Future Function() onRefresh;
  final Future Function() onLoading;
  final Widget Function(BuildContext context) builder;
  final T viewModel;


  const PtrWidget({Key key,
    this.onRefresh,
    this.onLoading,
    this.enablePullUp:false,
    this.enablePullDown:true,
    this.enableTwoLevel:false,
    this.initFuture:true,
    this.builder,
    this.viewModel
  }) : super(key: key);





  @override
  _PtrWidgetState createState() => _PtrWidgetState();
}

class _PtrWidgetState extends BaseWidgetState<PtrWidget,PtrController> {

  @override
  PtrController getController() =>  widget.viewModel.ptrController??PtrController();


  @override
  void initState() {
    super.initState();

    controller.setRequestFun(request);
    if(widget.initFuture)
      controller.request();
  }

  void request() async{
    controller.init = true;
    var code = await widget.onRefresh?.call();
    controller.state = code;
  }

  @override
  Widget build(BuildContext context) {

    return SmartRefresher(
      // physics: AlwaysScrollableScrollPhysics(),
      enablePullDown: widget.enablePullDown,
      // dragStartBehavior: DragStartBehavior.down,
      // primary:true,
      header: WaterDropHeader(),        // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
      footer: ClassicFooter(),
      enableTwoLevel:widget.enableTwoLevel,
      enablePullUp: widget.enablePullUp,
      controller: controller.refreshCtr,
      onRefresh: () async{
        controller.init = false;
        var code = await widget.onRefresh?.call();
        controller.state = code;
      },
      onLoading: () async{
        var code = await widget.onLoading?.call();
        controller.state = code;
      },
      child:child,

    );
  }

  Widget get child {
    if(!controller.init){
      return widget.builder(context);
    }
    if(controller.state == 1){
      controller.init = false;
      return widget.builder(context);
    }

    return widget.viewModel.stateWidget(state: controller.state,onPressed: (){
      controller.request();
    });

  }

}


class PtrController extends BaseWidgetController{


  Function() _requestFun;

  bool init = true;

  void setRequestFun(Function() _requestFun){
    this._requestFun = _requestFun;
  }

  void request(){
    _requestFun?.call();
  }



  RefreshController refreshCtr;

  final bool initialRefresh;

  PtrController({this.initialRefresh:false}) {
    refreshCtr = RefreshController(initialRefresh: initialRefresh);
  }

  static final int waiting = 0;
  static final int done = 1;
  static final int hasError = -1;

  int _state = waiting;

  int get state => _state;

  set state(int value) {
    _state = value;
    notifyUI();
  }

  @override
  void dispose() {
    refreshCtr?.dispose();
    super.dispose();
  }
}
