

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hydhome/base/adapter/BaseAdapter.dart';

class SwiperZ{

  static Swiper build<T>(BaseAdapter<T> adapter,{
    SwiperController controller,
    double containerHeight,
    double containerWidth,
    double itemWidth,
    double itemHeight,
    bool loop:true,
    Axis scrollDirection:Axis.horizontal,
    bool autoplay: true,
    int autoplayDely: 3000,
    SwiperPagination pagination,//: const SwiperPagination(),//默认分页指示器
    SwiperControl control,//: const SwiperControl(),
    SwiperOnTap onTap,
  }){

    return Swiper(//
      controller: controller,
      itemCount: adapter.getItemCount(),
      itemBuilder: (BuildContext context, int index){
        return adapter.onCreateViewHolder(context, index);
      },
      containerHeight: containerHeight,
      containerWidth: containerWidth,
      itemWidth: itemWidth,
      itemHeight: itemHeight,
      loop: loop,
      scrollDirection: scrollDirection,
      autoplay: autoplay,
      autoplayDelay: autoplayDely,
      autoplayDisableOnInteraction: true,
      pagination: pagination,
      control: control,
      onTap: onTap,

    );
  }
}