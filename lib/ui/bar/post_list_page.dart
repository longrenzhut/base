
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hydhome/base/adapter/BaseGvAdapter.dart';
import 'package:hydhome/base/adapter/BasePvAdapter.dart';
import 'package:hydhome/base/common/BaseNoPage.dart';
import 'package:hydhome/base/provider/provider_widget.dart';
import 'package:hydhome/base/utils/Adapt.dart';
import 'package:hydhome/base/utils/ImageHelper.dart';
import 'package:hydhome/base/utils/MyColors.dart';
import 'package:hydhome/base/utils/ToastUtil.dart';
import 'package:hydhome/base/widget/Swiper/SwiperZ.dart';
import 'package:hydhome/base/widget/list/GridViewZ.dart';
import 'package:hydhome/base/widget/list/ListZ.dart';
import 'package:hydhome/base/widget/list/PageViewZ.dart';
import 'package:hydhome/base/widget/ptr/ptr_widget.dart';
import 'package:hydhome/base/widget/view/SpaceWidget.dart';
import 'package:hydhome/ui/bar/adapter/HeadLineAdapter.dart';
import 'package:hydhome/ui/bar/adapter/HeaderTypeAdapter.dart';
import 'package:hydhome/ui/bar/adapter/PostListAdapter.dart';
import 'package:hydhome/ui/bar/view_model/PostListModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'adapter/BannerAdapter.dart';
import 'entity/header_entity.dart';

//帖子列表
class PostListPage extends BaseNoPage{
  ScrollController scrollController;
  PostListPage({this.scrollController});
  @override
  Widget getContentWidget(BuildContext context) {

    var _postListAdapter = PostListAdapter();

    return ProviderWidget<PostListModel>(
        wantKeepAlive: true,
        model: PostListModel(),
        onModelReady: (model){
          model.initData();
        },
        builder: (context,model,child){
          _postListAdapter.setDatas(model.list);
          return  model.builder(
              child: PtrWidget.build(
                  onRefresh: model.refresh,
                  onLoading: model.loadMore,
                  controller: model.refreshController,
                  child: ListZ.build(_postListAdapter,
                      header: HeaderBannerWidget(model.headerEntity),
                      controller: scrollController)
              )
          );
        }

    );
  }
}

class HeaderBannerWidget extends StatefulWidget {


  HeaderEntity _headerEntity;


  HeaderBannerWidget(HeaderEntity _headerEntity){
    this._headerEntity = _headerEntity;
  }

  @override
  _HeaderBannerWidgetState createState() => _HeaderBannerWidgetState();
}

class _HeaderBannerWidgetState extends State<HeaderBannerWidget> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {

    HeaderTypeAdapter _headerTypeAdapter = HeaderTypeAdapter();
    _headerTypeAdapter.setDatas(widget._headerEntity.typeInfo);

    HeadLineAdapter _headLineAdapter = HeadLineAdapter();
    _headLineAdapter.setDatas(widget._headerEntity.headlineInfo);
    return Column(
      children: <Widget>[
        Container(
          height: Adapt.setHeight(176),
          color: Colors.grey[300],
          child: SwiperZ.build(BannerAdapter().setDatas(widget._headerEntity.bannerInfo),
              itemHeight: Adapt.setWidth(176),
              scrollDirection: Axis.vertical,
              onTap: (index){
                ToastUtil.showToast("点击了$index");
              }
          ),
        ),
        GridViewZ.build(_headerTypeAdapter),

        SpaceWidget(10,color: Colors.grey[100],),
        SizedBox(
          height: Adapt.setWidth(40),
          child: SwiperZ.build(_headLineAdapter,
              containerHeight: Adapt.setWidth(40),
              scrollDirection: Axis.vertical,
              onTap: (index){
                ToastUtil.showToast("点击了$index");
              }
          ),
        ),


      ],
    );;
  }

  @override
  bool get wantKeepAlive => true;
}




