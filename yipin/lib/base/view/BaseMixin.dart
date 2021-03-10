
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/ImageHelper.dart';
import '../utils/CstColors.dart';
import '../widget/LinearWidget.dart';
import '../widget/TextView.dart';

mixin BaseMixin {


  Widget getView(BuildContext context);

  Widget getAppBar(BuildContext context){
    return null;
  }

  Widget getBottomNavigationBar(BuildContext context) {
    return null;
  }


  Map _argumentsMap;
  Map argumentOf(BuildContext context) {
    if(null == _argumentsMap)
      _argumentsMap = ModalRoute.of(context).settings.arguments;
    if(null == _argumentsMap){
      _argumentsMap = {};
    }
    if(_argumentsMap.length > 0)
      print("页面参数传递： " + _argumentsMap.toString());
    return _argumentsMap;
  }

  T providerOf<T>(BuildContext context){
    return Provider.of<T>(context,listen: false);
  }



  Widget  setItemTitleWidget(String title, {  EdgeInsetsGeometry margin}){
    return LinearWidget(
      margin: margin,
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 6,),
        TextView(title,size: 16,color: CstColors.cl_00020D,weight: FontWeight.bold),
      ],
    );
  }

  Widget topWidget(BuildContext context,String title,{bool offstage:false, Function() onTop}){
    return LinearWidget(
      direction: Axis.horizontal,

      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 6,),
        TextView(title,size: 16,color: CstColors.cl_00020D,weight: FontWeight.bold),
        Spacer(),
        Offstage(
          offstage: offstage,
          child:   InkWell(
            child: ImageHelper.buildImage("ic_close.png",width: 16,height: 16),
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
