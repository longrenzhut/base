
import 'package:flutter/material.dart';
import '../../../base/utils/ImageHelper.dart';
import '../../../base/utils/CstColors.dart';
import '../../../base/widget/TextView.dart';
import '../../../base/model/ItemModel.dart';
import '../../../base/view/BaseWidget.dart';

class BottomBarWidget extends StatefulWidget {

  final BottomBarController controller;
  final Function(int index) indexCallback;

  const BottomBarWidget({Key key, this.controller,this.indexCallback}) : super(key: key);

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
    controller.setIndexCallback(widget.indexCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 54,
        child: Row(
          children: List.generate(controller.barList.length, (index) {
            var model = controller.barList[index];
            var imageName = controller.index == index ? model.iconSelected : model.icon;
            var color = controller.index != index ? CstColors.cl_727066 : CstColors.black;
            return  Expanded(child:
            InkWell(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageHelper.buildImage(imageName,width: 20,height: 20,type: 1,fit: BoxFit.fitHeight),
                SizedBox(height: 8,),
                TextView(model.title,color: color,size: 12,)
              ],
            ),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () async{
                await Future.delayed(Duration(milliseconds: 200), () {
                  controller.setIndex(index);
                });
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

  Function(int index) indexCallback;

  setIndexCallback(Function(int index) indexCallback){
    this.indexCallback = indexCallback;
  }

  @override
  void setIndex(int index) {
    // TODO: implement setIndex
    super.setIndex(index);
    indexCallback?.call(index);
  }

}


