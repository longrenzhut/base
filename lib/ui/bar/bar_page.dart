
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hydhome/base/common/BaseNoPage.dart';
import 'package:hydhome/base/provider/provider_widget.dart';
import 'package:hydhome/base/utils/Adapt.dart';
import 'package:hydhome/base/utils/ImageHelper.dart';
import 'package:hydhome/base/utils/UIHelper.dart';
import 'package:hydhome/base/widget/tab/indicator/MD2IndicatorSize.dart';
import 'package:hydhome/base/widget/view/SpaceWidget.dart';
import 'package:hydhome/base/widget/view/StatusBarWidget.dart';
import 'package:provider/provider.dart';

import 'airec_page.dart';
import 'post_list_page.dart';
import 'view_model/ScrollchangeModel.dart';

class BarPage extends StatefulWidget {
  @override
  _BarPageState createState() => _BarPageState();
}

class _BarPageState extends State<BarPage> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  TabController _tabController;

  ScrollController  _scrollController;

  @override
  void initState() {
    super.initState();
     _tabController = TabController(length: 2,vsync: this);

    _scrollController = ScrollController();

  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        TabBarView(
          physics:NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            PostListPage(scrollController: _scrollController),
            AirecPage()
          ],
        ),
        ProviderWidget(
            model: ScrollchangeModel(),
            onModelReady: (model){
              _scrollController.addListener((){
                var currentY = _scrollController.offset;
                if(currentY < 0)
                  return;
                var h = Adapt.setHeight(176);
                var scale = 1.0;
                if(currentY < h){
                  scale = currentY/h;
                }
                var alpha = (255 * scale).toInt();
                var color =  Color.fromARGB(alpha, alpha, alpha, alpha);

                if(scale >= 1.0){
                  model.personIcon = "person_black";
                  model.searchIcon = "search_black";
                  model.lineColor = Colors.black;
                }
                else {
                  model.personIcon = "person";
                  model.searchIcon = "search";
                  model.lineColor = Colors.white;
                }

                model.color = color;
              });
            },
            builder: (context,model,child) {
              return Column(
                children: <Widget>[
                  StatusBarWidget(color: model.color,),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      SpaceWidget(46,color: model.color,),
                      Positioned(
                        top: Adapt.setWidth(12),
                        left: Adapt.setWidth(12),
                        child: ImageHelper.icon(model.personIcon,height: 28,width: 28),
                      ),
                      Positioned(
                        top: Adapt.setWidth(12),
                        right: Adapt.setWidth(12),
                        child: ImageHelper.icon(model.searchIcon,height: 28,width: 28),
                      ),
                      TabBar(
                        labelPadding: UIHelper.horizontal(28),
                        controller: TabController(length: 2,vsync: this),
                        labelColor: model.lineColor,
                        unselectedLabelColor: model.lineColor,
                        labelStyle: UIHelper.textStyle(fontsize: 18,fontWeight: FontWeight.w300,
                        ),
                        unselectedLabelStyle: UIHelper.textStyle(fontsize: 18,
                          fontWeight: FontWeight.w100,
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: MD2Indicator(
                            indicatorHeight: 3,
                            indicatorColor: model.lineColor,
                            indicatorSize: MD2IndicatorSize.normal
                        ),

                        isScrollable: true,
                        tabs: <Widget>[
                          Tab(
                            text: "财吧",
                          ),
                          Tab(
                            text: "推荐",
                          )

                        ],
                        onTap:(index){
                          _tabController.index = index;
                        },
                      )

                    ],
                  )
                ],
              );
            }
        )


      ],


    );
  }

  @override
  bool get wantKeepAlive => true;
}
