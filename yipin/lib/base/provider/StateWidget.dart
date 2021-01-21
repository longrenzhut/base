import '../utils/ImageHelper.dart';
import '../utils/MyColors.dart';
import '../widget/LinearWidget.dart';
import '../widget/MyButton.dart';

import '../widget/TextView.dart';
import 'package:flutter/material.dart';



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
        ImageHelper.loadAssert("ic_net_error.png",width: 300,height: 224),
        SizedBox(height: 12,),
        TextView("无法连接到网络",color: MyColors.cl_161722,size: 18,),
        SizedBox(height: 10,),
        TextView("请检查网络设置或稍后重试",color: MyColors.cl_7B8290,size: 14,),
        SizedBox(height: 10,),
        MyButton(text: "重试", onPressed: onPressed,type: 2,)
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ImageHelper.loadAssert("ic_nodata.png",width: 108,height: 120),
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





