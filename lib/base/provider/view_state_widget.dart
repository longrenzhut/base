import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hydhome/base/utils/UIHelper.dart';


/// 加载中
class ViewStateBusyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}


/// 加载失败页面
class ViewStateErrorWidget extends StatelessWidget {

  VoidCallback onPressed;
  ViewStateErrorWidget({
    this.onPressed
});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        child: Text( "加载失败",
          style: UIHelper.textStyle(fontsize: 18,color: Colors.black),),
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
      child: Text("页面无数据",style: UIHelper.textStyle(fontsize: 18,color: Colors.black),),
    );
  }
}

/// 页面未授权登录
class ViewStateUnAuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("页面未授权",style: UIHelper.textStyle(fontsize: 18,color: Colors.black),),
    );
  }
}





