

import 'package:flutter/material.dart';
import 'package:hydhome/base/adapter/BaseAdapter.dart';
import 'package:hydhome/base/utils/Adapt.dart';
import 'package:hydhome/base/utils/ImageHelper.dart';
import 'package:hydhome/base/utils/MyColors.dart';
import 'package:hydhome/base/utils/UIHelper.dart';
import 'package:hydhome/base/widget/view/SpaceWidget.dart';
import 'package:hydhome/ui/bar/entity/header_entity.dart';

class HeadLineAdapter extends BaseAdapter<HeaderHeadlineinfo>{

  HeadLineAdapter():super(isClick:false);

  @override
  Widget onBindViewHolder(BuildContext context, int index, HeaderHeadlineinfo model) {
    return Container(
        height: Adapt.setWidth(42),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SpaceWidget(12,isVerSpace: false,),
            ImageHelper.icon("icon_new",width: 32,height: 16),
            SpaceWidget(10,isVerSpace: false,),
            Text(model.title,style: UIHelper.textStyle(fontsize: 16,color: MyColors.cl_111928,
            fontWeight: FontWeight.w300),),
            SpaceWidget(12,isVerSpace: false,),
          ],

        ),

    );
  }

}