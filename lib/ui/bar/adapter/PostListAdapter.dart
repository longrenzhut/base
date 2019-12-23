
import 'package:flutter/material.dart';
import 'package:hydhome/base/adapter/BaseAdapter.dart';
import 'package:hydhome/base/router/RouterHepler.dart';
import 'package:hydhome/base/utils/Adapt.dart';
import 'package:hydhome/base/utils/ImageHelper.dart';
import 'package:hydhome/base/utils/MyColors.dart';
import 'package:hydhome/base/utils/UIHelper.dart';
import 'package:hydhome/base/widget/view/SpaceWidget.dart';
import 'package:hydhome/ui/bar/entity/post_entity.dart';

class PostListAdapter extends BaseAdapter<PostEntity>{


  @override
  Widget onBindViewHolder(BuildContext context, int index, PostEntity model) {

    Color soild = index % 2 == 0? MyColors.cl_FFEEDC : MyColors.cl_E6F4FF;
    Color border = index % 2 == 0? MyColors.cl_FFDBB3 : MyColors.cl_BAD4FF;


    var  message = model.message.replaceAll("\\n","\n");
    return Column(
      children: <Widget>[
        SpaceWidget(20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SpaceWidget(12,isVerSpace: false),
            Container(
              alignment: Alignment.center,
              padding: UIHelper.horizontal(6),
              height: Adapt.setHeight(18),
              decoration: UIHelper.boxDecoration(
                soildColor: soild,
                borderColor: border,
                width: 1,
                radius: 2,
              ),
              child: Text(model.typeName,style: UIHelper.textStyle(fontsize: 12,color: MyColors.cl_1F2736),),
            ),
            SpaceWidget(6,isVerSpace: false),

            Text(model.subject,style: UIHelper.textStyle(fontsize: 18,color: MyColors.cl_1F2736,fontWeight: FontWeight.w200),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SpaceWidget(12,isVerSpace: false),

          ],
        ),
        SpaceWidget(15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SpaceWidget(12,isVerSpace: false),
            Expanded(
              child: Text(message,style: UIHelper.textStyle(fontsize: 16,color: MyColors.cl_1F2736),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              ),
            ),
            Offstage(
              offstage: model.imageUrl.isEmpty,
              child: ImageHelper.loadWH(model.imageUrl,
                  width: 116,height: 70),
            ),

            SpaceWidget(12,isVerSpace: false),
          ],

        ),
        Offstage(
          offstage: model.imageUrl.isEmpty,
          child: SpaceWidget(15),
        ),

        Row(
          children: <Widget>[
            SpaceWidget(12,isVerSpace: false,),
            ImageHelper.loadCircle(model.avatarUrl,26),
            SpaceWidget(4,isVerSpace: false,),
            Expanded(
              child: Text(model.nickname,style: UIHelper.textStyle(fontsize: 14,color: MyColors.cl_1F2736),
              maxLines: 1, overflow: TextOverflow.ellipsis,)
            ),
            SpaceWidget(10,isVerSpace: false,),
            ImageHelper.icon("lands",width: 12,height: 12),
            SpaceWidget(4,isVerSpace: false,),
            Text("${model.views > 99? "99+": model.views}",style: UIHelper.textStyle(fontsize: 12,color: MyColors.cl_9BA0AA),),
            SpaceWidget(10,isVerSpace: false,),
            ImageHelper.icon("readcount",width: 12,height: 12),
            SpaceWidget(4,isVerSpace: false,),
            Text("${model.posts > 99? "99+": model.posts}",style: UIHelper.textStyle(fontsize: 12,color: MyColors.cl_9BA0AA),),
            SpaceWidget(10,isVerSpace: false,),
            ImageHelper.icon("commentcount",width: 12,height: 12),
            SpaceWidget(4,isVerSpace: false,),
            Text("${model.lauds > 99? "99+": model.lauds}",style: UIHelper.textStyle(fontsize: 12,color: MyColors.cl_9BA0AA),),
            SpaceWidget(12,isVerSpace: false,),
          ],
        ),
        SpaceWidget(20),
      ],

    );
  }

  @override
  Color getDividerColor() {
    return MyColors.cl_1A1E283C;
  }

  @override
  double getDividerHeight() {
    return 1;
  }

  @override
  void onItemClicked(BuildContext context, int index, PostEntity model) {

    RouterHepler.buildPostDetail(context,model.tid.toString());

  }
}