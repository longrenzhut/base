

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../painting/MyDecoration.dart';
import '../utils/ImageHelper.dart';
import '../utils/MyColors.dart';
import '../widget/LinearWidget.dart';
import '../widget/TextView.dart';


class ToastUtil{


  static void showSucToast(String text){
    showToast(text,error: false);
  }

  static void showToast(String text,{bool error: true}){
    if(null == text || text.length == 0)
      return;
    BotToast.showText(text: text);
    // BotToast.showCustomNotification(
    //     enableSlideOff:false,
    //     toastBuilder: (value){
    //       var stroke = error? MyColors.cl_D48B8B : MyColors.cl_8BD4B5;
    //       var solid = error? MyColors.cl_FFEEEE : MyColors.cl_EEFFF8;
    //       var color = error? MyColors.cl_F92E2E : MyColors.cl_019A5A;
    //       var name = error? "ic_toast_error.png" : "ic_toast_suc.png";
    //       return Container(
    //         margin: EdgeInsets.only(top: 80),
    //         alignment: Alignment.topCenter,
    //         child:LinearWidget(
    //           direction: Axis.horizontal,
    //           height: 34,
    //           padding: EdgeInsets.symmetric(horizontal: 20),
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           decoration: MyDecoration.boxDecorationAllRadius(
    //               stroke: stroke,
    //               solid: solid
    //           ),
    //           children: [
    //             ImageHelper.loadAssert(name,width: 16,height: 16),
    //             SizedBox(width: 6,),
    //             TextView(text,size: 14,color: color,)
    //           ],
    //         ),
    //       );
    //     });

  }
  static showDialog(){
    BotToast.showLoading(backgroundColor:Colors.black26,);
  }


  static dismiss(){
    BotToast.closeAllLoading();
  }


}