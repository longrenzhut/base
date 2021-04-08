

import 'package:base/utils/ImageHelper.dart';
import 'package:base/utils/CstColors.dart';
import 'package:base/widget/LinearWidget.dart';

import 'package:base/widget/TextView.dart';
import 'package:flutter/material.dart';


class StateWidget extends StatelessWidget {

  final Widget Function(BuildContext context) errorBuilder;
  final Widget Function(BuildContext context) selfBuilder;


  final int state;
  final VoidCallback onPressed;

  const StateWidget({Key key,
    this.errorBuilder,
    this.selfBuilder,
    this.onPressed,
    this.state:0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(state){
      case 0: //加载动画中
        return ViewStateBusyWidget();
      case -1:
        return errorBuilder?.call(context)??ViewStateErrorWidget(onPressed: onPressed,);
    }
    return selfBuilder?.call(context)??ViewStateFailedWidget(onPressed: onPressed,);
  }
}


/// 加载中
class ViewStateBusyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 200),
      child: Align(
        alignment: Alignment.topCenter,
        child: CircularProgressIndicator(),
      ),
    );
  }
}


/// 网络请求失败页面
class ViewStateErrorWidget extends StatelessWidget {

  final VoidCallback onPressed;
  ViewStateErrorWidget({
    this.onPressed
});

  @override
  Widget build(BuildContext context) {
    return LinearWidget(
      bgColor: Colors.white,
      alignment: Alignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageHelper.buildImage("ic_net_error.png",width: 300,height: 224,type: 1),
        SizedBox(height: 12,),
        TextView("无法连接到网络",color: CstColors.cl_161722,size: 18,),
        SizedBox(height: 10,),
        TextView("请检查网络设置或稍后重试",color: CstColors.cl_7B8290,size: 14,),
        SizedBox(height: 10,),
        InkWell(child: TextView("重试"),
          onTap: onPressed
          ,)
      ],
    );


//      Center(
//      child: FlatButton(
//        child: TextView( "加载失败",size: 18, color: Colors.black ),
//        onPressed: onPressed,
//      )
//    );
  }
}

/// 网络请求失败页面
class ViewStateFailedWidget extends StatelessWidget {

  final VoidCallback onPressed;
  final String text;
  ViewStateFailedWidget({
    this.onPressed,
    this.text
});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        child: TextView(text,size: 18, color: Colors.black ),
        onPressed: onPressed,
      )
    );
  }
}

/// 页面无数据
class ViewStateEmptyWidget extends StatelessWidget {

  final String title;

  const ViewStateEmptyWidget({Key key, this.title}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageHelper.buildImage("ic_nodata.png",width: 80,height: 70,type: 1),
          TextView(title??"暂无数据",size: 14,color: Colors.black,)
        ],
      ),
    );
  }
}

/// 页面未授权登录
class ViewStateUnAuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextView("页面未授权",size: 18, color: Colors.black ),
    );
  }
}





