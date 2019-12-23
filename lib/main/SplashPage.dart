

import 'package:flutter/material.dart';
import 'package:hydhome/base/common/BaseNoPage.dart';
import 'package:hydhome/base/router/RouterHepler.dart';
import 'package:hydhome/base/utils/ImageHelper.dart';

class SplashPage extends BaseNoPage{

  @override
  Widget getContentWidget(BuildContext context) {

    return WillPopScope(
      //ic_bg_splash ic_bg_logo
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child:  ImageHelper.icon("ic_bg_splash",width: double.infinity,height:double.infinity ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: ImageHelper.icon("ic_bg_logo",width: 233,height:double.infinity,boxFit:BoxFit.scaleDown),
            )
          ),
          EnterOpen()
        ],
      ),
      onWillPop:()  => Future.value(false),
    );
  }


}

class EnterOpen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    openNext(context);
    return Container();
  }


  void openNext(BuildContext context) async{
    await Future.delayed(Duration(microseconds: 2000))
        .then((value){
      RouterHepler.buildHome(context);
    });
  }
}
