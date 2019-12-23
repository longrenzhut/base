import 'package:flutter/material.dart';
import 'package:hydhome/base/common/HeaderModel.dart';
import 'package:hydhome/base/provider/provider_widget.dart';
import 'package:hydhome/base/router/RouterHepler.dart';
import 'package:hydhome/base/utils/Adapt.dart';
import 'package:hydhome/base/utils/ImageHelper.dart';
import 'package:hydhome/base/utils/MyColors.dart';
import 'package:hydhome/base/utils/UIHelper.dart';
import 'package:hydhome/base/widget/view/SpaceWidget.dart';
import 'package:hydhome/base/widget/view/StatusBarWidget.dart';
import 'package:provider/provider.dart';

abstract class BasePage extends StatelessWidget {



  final String title;

  final String rightText;
  final bool isLeft;

  BuildContext mContext;


  BasePage({this.title:"",this.rightText:""
    ,this.isLeft:false});



  bool isUserHeader() {
    return true;
  }

  bool isUserstatusBar() {
    return true;
  }

  Widget getHeaderWidget() {
    return null;
  }

  void setOnLeft(BuildContext context){
    RouterHepler.pop(context);
  }

  void setOnRight(BuildContext context,String text){

  }


  Widget getAppBar(BuildContext context) {
    List<Widget> widgets = [];
    double appbarH = 0.0;
    widgets.clear();
    if (isUserstatusBar()) {
      appbarH = Adapt.getStaBarH();
      widgets.add(StatusBarWidget());
    }
    if (isUserHeader()) {
      widgets.add(HeaderWidget(title: title, rightText: rightText, isLeft: isLeft,
        leftFun:(){
          setOnLeft(context);
        },
        rightFun:(){
          setOnRight(context,rightText);
        },
      ));
      appbarH += Adapt.setHeight(44);
    }
    else {
      if (null != getHeaderWidget()) {
        appbarH += Adapt.setHeight(44);
        widgets.add(getHeaderWidget());
      }
    }
    if (widgets.length == 0)
      return null;
    return PreferredSize(
      preferredSize: Size.fromHeight(appbarH) ,
      child: Column(
        children: widgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    this.mContext = context;
    initWidget(context);
    return Scaffold(
      appBar: getAppBar(context),
      body: getContentWidget(context),
      bottomNavigationBar: getbottomNavigationBar(context),
    );
  }

  void initWidget(BuildContext context);

  Widget getContentWidget(BuildContext context);

  Widget getbottomNavigationBar(BuildContext context){

    return null;
  }

  void setTitle(BuildContext c, String title){

    Provider.of<HeaderModel>(c).title = title;
  }
//
//  void setTitleTv(String title,String rightText){
//    this.title = title;
//    this.rightText = rightText;
//  }
//
//  void setIvTitleTv(String titleTv,String rightText){
//    isLeft = true;
//    this.title = title;
//    this.rightText = rightText;
//  }



}





class HeaderWidget extends StatelessWidget {

  final String title;
  final String rightText;
  final bool isLeft;
  final Function leftFun;
  final Function rightFun;

  HeaderWidget({
    this.title: "",
    this.isLeft: false,
    this.leftFun,
    this.rightFun,
    this.rightText: "",});


  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HeaderModel>(
        model: HeaderModel(),
        onModelReady: (model) {
          model.title = title;
          model.isLeft = isLeft;
          model.rightText = rightText;
        },
        builder: (c, model, child) {
          return Container(
            width: double.infinity,
            height: Adapt.setHeight(44),
            color: Colors.white,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Text(model.title, style: UIHelper.textStyle(
                    fontsize: 18, color: MyColors.cl_111928),
                    textAlign: TextAlign.center),

                Positioned(
                  left: 4,
                  child: Offstage(
                      offstage: !model.isLeft,
                      child: ImageHelper.iconBtn(
                          "back", width: 28, height: 28, f: leftFun)
                  ),
                ),

                Positioned(
                  right: 12,
                  child: Offstage(
                    offstage: model.rightText.isEmpty,
                    child: SizedBox(
                      height: Adapt.setHeight(28),
                      child: FlatButton(


                      ),
                    ),
                  ),
                )

              ],

            ),
          );
        }
    );
  }
}










