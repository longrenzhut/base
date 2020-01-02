

import 'package:flutter/material.dart';
import 'package:hydhome/base/common/BasePage.dart';
import 'package:hydhome/base/provider/provider_widget.dart';
import 'package:hydhome/base/router/RouterHepler.dart';
import 'package:hydhome/base/utils/Adapt.dart';
import 'package:hydhome/base/utils/ImageHelper.dart';
import 'package:hydhome/base/utils/MyColors.dart';
import 'package:hydhome/base/widget/view/CheckBotton.dart';
import 'package:hydhome/ui/bar/view_model/PostDetailModel.dart';

class PosDetailPage extends BasePage{

  final String id;

  PosDetailPage({this.id});

  @override
  bool isUserHeader() {
    return false;
  }

  @override
  Widget getHeaderWidget() {
    return Container(
      width: double.infinity,
      height: Adapt.setHeight(44),
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: Adapt.setWidth(4),
            child: ImageHelper.iconBtn(
                "back", width: 28, height: 28, f: (){
              RouterHepler.pop(mContext);
            }),
          ),
          Positioned(
            right: Adapt.setWidth(12),
            child: CheckBotton("楼主",
              radius: 14,
              height: 50,
              width: double.maxFinite,
              checkedsolid: MyColors.cl_067C5F,
              solid: Colors.white,
              checkedstroke: MyColors.cl_067C5F,
              stroke: MyColors.cl_DEE4EA,
              strokeWidth: 1,
              fontSize: 14,
              textcolor: MyColors.cl_1F2736,
              checkFun: (isChecked){

              },
            ),
          )
        ],

      ),
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {

    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
              child: ProviderWidget<PostDetailModel>(
                model: PostDetailModel(),
                onModelReady: (model){
                  model.getPostDet();
                },
                builder: (context,model,child){
                  return null;
                },
              )
          ),

        ],

      ),
    );
  }

  @override
  void initWidget(BuildContext context) {
  }


}

