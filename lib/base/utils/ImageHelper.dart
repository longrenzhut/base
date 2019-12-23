import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hydhome/base/utils/UIHelper.dart';

import 'Adapt.dart';

class ImageHelper {
  static String png(String name) {
    return "assets/images/$name.png";
  }

  static Widget icon(String name, {double width, double height, BoxFit boxFit = BoxFit.fitHeight}) {
    var w = width == double.infinity ? double.infinity: Adapt.setWidth(width);
    var h = height == double.infinity ? double.infinity: Adapt.setWidth(height);
    return Image.asset(
      png(name),
      width: w,
      height: h,
      fit: boxFit,
    );
  }

  static IconButton iconBtn(String name,{double width, double height
    ,Function f
    ,Alignment alignment = Alignment.centerLeft
    ,EdgeInsets padding = const EdgeInsets.all(8)
  }) {
    return IconButton(
        alignment: alignment,
        color: Colors.white,
        icon: ImageHelper.icon(name,width: width,height: height),
        splashColor: Colors.grey[100],
        highlightColor: Colors.grey[100],
        padding: padding,
        onPressed: f,
    );
  }

  static Widget loadWH(String url,{Object width,Object height}){
    if(url.isEmpty)
      return  Container(
        width: Adapt.setWidth(width),
        height: Adapt.setWidth(width),
        color: Colors.grey[500],
      );
    Object newWidth = width == 0 ? null :Adapt.setWidth(width);
    return CachedNetworkImage(
      imageBuilder: (context,provider){
        return Image(image: provider, width: newWidth,height: Adapt.setWidth(height),
            fit:BoxFit.fitWidth);
      },
      imageUrl: url,
//      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  static Widget loadCircle(String url,width){
    if(url.isEmpty)
      return  Container(
        width: Adapt.setWidth(width),
        height: Adapt.setWidth(width),
        decoration: UIHelper.boxDecoration(
            radius: Adapt.setWidth(width)/2 + 10,
            soildColor: Colors.grey[500]
        ),
      );
    return ClipRRect(
      borderRadius: BorderRadius.circular(Adapt.setWidth(width)/2),
      child: CachedNetworkImage(
        imageBuilder: (context,provider){
          return Image(image: provider, width: Adapt.setWidth(width),height: Adapt.setWidth(width),
          fit: BoxFit.fitWidth,);
        },
        imageUrl: url,

//      placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      )
    );
  }

}
