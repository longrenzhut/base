


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:base/utils/BaseUtils.dart';

class ImageHelper {

  static String png(String name,{int type}){
    if(type == 0)
      return "assets/images/$name";
    return "assets/common/$name";
  }

  static Image buildImage(String name,{double height,double width,int type:0,BoxFit fit}){

    return Image.asset(png(name),height: height, width: width,fit: fit,);
  }

  static AssetImage buildAssetImage(String name,{double height,double width}){

    return AssetImage(png(name));
  }


  static Widget load(String url,{double width,double height,String placeholder: "ic_placeholder.png"}) {
    if (BaseUtils.isEmpty(url)) {
      return Container(
        width: width,
        height: height,
        child: buildImage(placeholder, width: width, height: height),
      );
    }

    return Container(
        width: width,
        height: height,
        child: CachedNetworkImage(
          fit: BoxFit.fitWidth,
          height: height,
          width: width,
          imageUrl: url,
          placeholder: (context, url){
            return  Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            );
          },
          errorWidget: (context, url, error) => Icon(Icons.error),
        )

    );
  }

//  http://oss.zcabc.com/oa/M00/00/00/rBAKdF6G_BOAcywWAAvea_OGt2M422.jpg

  static Widget loadCircle(String url,width){
    return ClipOval(
      child:  CachedNetworkImage(
        width: width,
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

}
