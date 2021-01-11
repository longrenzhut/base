
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/ImageHelper.dart';
import '../utils/MyColors.dart';
import '../widget/LineView.dart';
import '../widget/LinearWidget.dart';
import '../widget/TextView.dart';

mixin BaseMixin {


  Widget getView(BuildContext context);

  Widget getAppBar(BuildContext context){
    return null;
  }


  Map  argumentOf(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    return map;
  }



  //  show({Future<dynamic> reqCallback}){
//    BotToast.showCustomNotification(
//      toastBuilder: (value){
//        reqCallback.then((t) => value);
//
//      return NetLoadingDialog(
//        outsideDismiss: false,
//      );
//    },
//    );
//  }
//
    T providerOf<T>(BuildContext context){
    return Provider.of<T>(context,listen: false);
  }







  Widget  setItemTitleWidget(String title, {  EdgeInsetsGeometry margin}){
    return LinearWidget(
      margin: margin,
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LineView(width: 3,height: 16, color: MyColors.cl_0FB36E,),
        SizedBox(width: 6,),
        TextView(title,size: 16,color: MyColors.cl_00020D,weight: FontWeight.bold),
      ],
    );
  }

  Widget topWidget(BuildContext context,String title,{bool offstage:false, Function() onTop}){
    return LinearWidget(
      direction: Axis.horizontal,

      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LineView(width: 2,height: 16, color: MyColors.cl_0FB36E,),
        SizedBox(width: 6,),
        TextView(title,size: 16,color: MyColors.cl_00020D,weight: FontWeight.bold),
        Spacer(),
        Offstage(
          offstage: offstage,
          child:   InkWell(
            child: ImageHelper.loadAssert("ic_close.png",width: 16,height: 16),
            onTap: (){
              if(onTop != null)
                onTop();
              else
                Navigator.of(context).pop();

            },
          ),
        )

      ],
    );
  }
}
