



import 'package:flutter/material.dart';
import '../delegate/PositionDelegate.dart';
import '../utils/MyColors.dart';
import '../utils/ToastUtil.dart';



class PopWindow extends StatefulWidget {

  final double height;
  final double width;
  final Decoration decoration;
  final double popHeight;
  final double popWidth;
  final bool outSideClose;
  final PopWindowController controller;
  final Future Function() future;
  final Widget child;
  final Offset target;
  final Function(PopWindowController controller) onReadyClick;
  final Widget Function(BuildContext context,PopWindowController controller) builder;

  const PopWindow({Key key,
    this.controller,
    @required this.builder,
    @required this.child,
    this.height,
    this.outSideClose: true,
    this.width,
    this.decoration,
    this.popHeight,
    this.future,
    this.popWidth,
    this.target,
    this.onReadyClick
  }) : super(key: key);

  @override
  _PopWindowState createState() => _PopWindowState();
}

class _PopWindowState extends State<PopWindow> {


  PopWindowController viewModel;


  @override
  void initState() {
    viewModel = widget.controller??PopWindowController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: widget.decoration,
        child: InkWell(
          child: widget.child,
          onTap: () async{
            if(widget.future == null || widget.controller.reqSuc)
              showPop();
            else{
              ToastUtil.showDialog();
              await widget.future.call().then((value) {
                if (value == 1){
                  widget.controller.reqSuc = true;
                  showPop();
                }
              }
              );
              ToastUtil.dismiss();
            }

          },
        ),
      ),
      onWillPop: () async {
        if(!viewModel.isBack()) {
          viewModel?.dismiss();
          return false;
        }
        return true;
      },
    );
  }


  void  showPop(){
    widget.onReadyClick?.call(widget.controller);
    final OverlayState overlayState = Overlay.of(context, debugRequiredFor: widget,);
    final RenderBox box = context.findRenderObject() as RenderBox;
    final RenderBox overlay = overlayState.context.findRenderObject() as RenderBox;
    final Offset target = widget.target??box.localToGlobal(
//      box.size.center(Offset.zero),
//      box.size.center(Offset(((widget.popWidth??widget.width) - widget.width)/2, 0.0)),
      box.size.center(Offset(0.0, 0.0)),
      ancestor: overlay,
    );
    var overlayEntry = createSelectPopupWindow(target);

    overlayState.insert(overlayEntry);

    viewModel.overlayEntryList.add(overlayEntry);
  }


  OverlayEntry createSelectPopupWindow(Offset target) {


    var preferBelow = (widget.popHeight??0) < target.dy;
    var child = widget.builder(context,viewModel);
    OverlayEntry overlayEntry = new OverlayEntry(
        builder: (context) {

          return Material(
            color: Colors.transparent,
            child: InkWell(
              focusColor: Colors.transparent, //
              splashColor: Colors.transparent,//点击扩散
              hoverColor: Colors.transparent, //鼠标放上去
              highlightColor: Colors.transparent,//点击
              child: Container(
                child: CustomSingleChildLayout(
                  delegate: PositionDelegate(
                    target: target,
                    verticalOffset: (widget.height??34)/2 + 10,
                    preferBelow: preferBelow,
                  ),
                  child: AnimPopWidget(
                    open: viewModel.isBack(),
                    child: child,
                    width: widget.popWidth,
                    height: widget.popHeight,
                  ),
                ),
              ),
              onTap: (){
                if(widget.outSideClose)
                viewModel.dismiss();
              },
            ),
          );
        });
    return overlayEntry;
  }


}


class AnimPopWidget extends StatefulWidget {

  final bool open;
  final Widget child;
  final double height;
  final double width;

  const AnimPopWidget({Key key, this.open:false, this.child, this.height, this.width}) : super(key: key);


  @override
  _AnimPopWidgetState createState() => _AnimPopWidgetState();
}

class _AnimPopWidgetState extends State<AnimPopWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Duration _fadeDuration = Duration(milliseconds: 300);
  Animation<double> get _animation => _controller.view;
  @override
  void initState() {
//    _controller = AnimationController(duration: _fadeDuration, vsync: this)
//      ..value = widget.open ? 0.0 : 1.0
//      ..addListener(() => setState(() { /* animation changed */ }));
    _controller = AnimationController(vsync: this, duration: _fadeDuration)..repeat();
    Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  FadeTransition(
      opacity: _animation,
      child: Container(
          constraints: BoxConstraints(
            minWidth: 100,
//              maxWidth: widget.width??200
          ),
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: MyColors.cl_33161722,
                    offset: Offset(0.0, 3.0), //阴影xy轴偏移量
                    blurRadius: 6.0, //阴影模糊程度
                    spreadRadius: 1.0 //阴影扩散程度
                )
              ]
          ),
          child: GestureDetector(
            child: Material(child: widget.child,),
            onTap: (){

            },
          )

      ),
    );

  }

}
//focusColor: Colors.transparent,
//splashColor: Colors.transparent,
//hoverColor: Colors.transparent,
//highlightColor: Colors.transparent,

class PopWindowController{

  bool reqSuc = false;

  List<OverlayEntry> overlayEntryList = [];

  bool isBack() => overlayEntryList.isEmpty;


  dismiss(){
    overlayEntryList?.forEach((element) {
      element.remove();
    });
    overlayEntryList?.clear();
  }

}
