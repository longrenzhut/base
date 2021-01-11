

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
    BotToast.showCustomNotification(
        enableSlideOff:false,
        toastBuilder: (value){
          var stroke = error? MyColors.cl_D48B8B : MyColors.cl_8BD4B5;
          var solid = error? MyColors.cl_FFEEEE : MyColors.cl_EEFFF8;
          var color = error? MyColors.cl_F92E2E : MyColors.cl_019A5A;
          var name = error? "ic_toast_error.png" : "ic_toast_suc.png";
          return Container(
            margin: EdgeInsets.only(top: 80),
            alignment: Alignment.topCenter,
            child:LinearWidget(
              direction: Axis.horizontal,
              height: 34,
              padding: EdgeInsets.symmetric(horizontal: 20),
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              decoration: MyDecoration.boxDecorationAllRadius(
                  stroke: stroke,
                  solid: solid
              ),
              children: [
                ImageHelper.loadAssert(name,width: 16,height: 16),
                SizedBox(width: 6,),
                TextView(text,size: 14,color: color,)
              ],
            ),
          );
        });

  }
  static showDialog({
      WrapAnimation wrapAnimation,
      WrapAnimation wrapToastAnimation,
      Alignment align = Alignment.center,
      BackButtonBehavior backButtonBehavior,
      bool crossPage = true,
      bool clickClose = false,
      bool allowClick = false,
      bool enableKeyboardSafeArea = true,
      VoidCallback onClose,
      Duration duration,
      Duration animationDuration,
      Duration animationReverseDuration,
      Color backgroundColor = Colors.black12,
    }) {


  BotToast.showLoading(backgroundColor:Colors.black26,);
//       BotToast.showCustomLoading(
//          wrapAnimation: wrapAnimation,
//          wrapToastAnimation: wrapToastAnimation,
//          align: align,
//          enableKeyboardSafeArea: enableKeyboardSafeArea,
//          backButtonBehavior: backButtonBehavior,
//          toastBuilder: (_) => Container(
//            padding: const EdgeInsets.all(15),
////            decoration: const BoxDecoration(
////                color: Colors.transparent,
////                borderRadius: BorderRadius.all(Radius.circular(8))),
//            child: const CircularProgressIndicator(
//              backgroundColor: Colors.white,
//            ),
//          ),
//          clickClose: clickClose,
//          allowClick: allowClick,
//          crossPage: crossPage,
//          ignoreContentClick: true,
//          onClose: onClose,
//          duration: duration,
//          animationDuration: animationDuration,
//          animationReverseDuration: animationReverseDuration,
//          backgroundColor: backgroundColor);
    }


  static dismiss(){
    BotToast.closeAllLoading();
  }


}