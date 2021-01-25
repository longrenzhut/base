
import 'package:flutter/material.dart';
import '../../../base/utils/ImageHelper.dart';
import '../../../base/utils/CstColors.dart';
import '../../../base/widget/TextView.dart';
import '../../../base/model/ItemModel.dart';
import '../../../base/view/BaseWidget.dart';

class BottomBarWidget extends StatefulWidget {

  final BottomBarController controller;
  final Function(int index) callback;

  const BottomBarWidget({Key key, this.controller,this.callback}) : super(key: key);

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends BaseWidgetState<BottomBarWidget,BottomBarController> {

  @override
  BottomBarController getController() =>  widget.controller??BottomBarController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.setcallback(widget.callback);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow:[
          BoxShadow(
            color: CstColors.cl_7DD1D1D1,
            offset: Offset(0.0, -3.0), //阴影xy轴偏移量
            blurRadius: 15.0, //阴影模糊程度
              spreadRadius: 6.0 //阴影扩散程度
          )
        ]
      ),
        height: 54,
        child: Row(
          children: List.generate(controller.barList.length, (index) {
            var model = controller.barList[index];
            return  Expanded(child:
            InkWell(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedCrossFade(
                  duration: Duration(milliseconds: 500),
                  crossFadeState:
                  controller.index == index ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  firstChild:  ImageHelper.buildImage(model.iconSelected,width: 20,height: 20,type: 1,fit: BoxFit.fitHeight),
                  secondChild:  ImageHelper.buildImage(model.icon,width: 20,height: 20,type: 1,fit: BoxFit.fitHeight),
                ),

                SizedBox(height: 8,),
                AnimatedCrossFade(
                  duration: Duration(milliseconds: 500),
                  crossFadeState:
                  controller.index == index ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  firstChild:  TextView(model.title,color: CstColors.black,size: 12,),
                  secondChild:  TextView(model.title,color: CstColors.cl_727066,size: 12,),
                ),

              ],
            ),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () async{
                  controller.setIndex(index);
              },
            )
            );
          }
          ),
        )
    );
  }
}

class BottomBarController extends BaseWidgetController{
  List<String> titles = ["首页","用户","营销","我的"];
  List<String> resourceSel = ["ic_home_selector.png","ic_users_selector.png","ic_marketing_selector.png","ic_my_selector.png"];
  List<String> resource = ["ic_home.png","ic_users.png","ic_marketing.png","ic_my.png"];

  List<ItemModel> barList;

  BottomBarController(){
    barList = List.generate(titles.length, (index) => ItemModel(
        title: titles[index],
        icon: resource[index],
        iconSelected: resourceSel[index]

    )).toList();
  }

  Function(int index) callback;

  setcallback(Function(int index) callback){
    this.callback = callback;
  }

  @override
  void setIndex(int index) {
    // TODO: implement setIndex
    super.setIndex(index);
    callback?.call(index);
  }

}


