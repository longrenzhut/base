

import 'package:flutter/material.dart';
import 'package:hydhome/base/adapter/BaseGvAdapter.dart';
import 'package:hydhome/base/utils/Adapt.dart';
import 'package:hydhome/base/utils/ImageHelper.dart';
import 'package:hydhome/base/utils/MyColors.dart';
import 'package:hydhome/base/utils/UIHelper.dart';
import 'package:hydhome/base/widget/view/SpaceWidget.dart';
import 'package:hydhome/ui/bar/entity/header_entity.dart';

class HeaderTypeAdapter extends BaseGvAdapter<HeaderTypeinfo>{
  @override
  int getSpanCount() {
    // TODO: implement getSpanCount
    return 4;
  }

  @override
  Widget onBindViewHolder(BuildContext context, int index, HeaderTypeinfo model) {
    // TODO: implement onBindViewHolder
    return Container(
      height: Adapt.setHeight(96),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ImageHelper.loadWH(model.typeIcon,width: 28,height: 28),
          SpaceWidget(8),
          Text(model.typeName,style: UIHelper.textStyle(fontsize: 12,color: MyColors.cl_1F2736))
        ],
      ),
    );
  }

}
