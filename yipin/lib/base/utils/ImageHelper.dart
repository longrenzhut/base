


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/BaseUtils.dart';

class ImageHelper {

  static String png(String name){
    return "images/image_zt/$name";
  }

  static Image loadAssert(String name,{double height,double width}){

    return Image.asset(png(name),height: height, width: width,);
  }

  static AssetImage assetImage(String name,{double height,double width}){

    return AssetImage(png(name));
  }


  static Widget load(String url,{double width,double height,String placeholder: "ic_placeholder.png"}) {
    if (BaseUtils.isEmpty(url)) {
      return Container(
        width: width,
        height: height,
        child: loadAssert(placeholder, width: width, height: height),
      );
    }

    return Container(
      width: width,
      height: height,
      child: CachedNetworkImage(
        fit: BoxFit.fitWidth,
        height: height,
        width: width,
//      imageBuilder: (context,provider){
//        var t = provider;
//        return Image(image: provider, width: width,height: height,
//            fit:BoxFit.fill);
//      },
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
//  static Widget loadCircle(String url,width){
//    if(BaseUtils.isEmpty(url))
//      return  Container(
//        width: Adapt.setWidth(width),
//        height: Adapt.setWidth(width),
//        decoration: UIHelper.boxDecorationAllRadius(
//            radius: Adapt.setWidth(width)/2,
//            solid: Colors.grey[500]
//        ),
//      );
//    return ClipRRect(
//        borderRadius: BorderRadius.circular(Adapt.setWidth(width)/2),
//        child: CachedNetworkImage(
//          imageBuilder: (context,provider){
//            return Image(image: provider, width: Adapt.setWidth(width),height: Adapt.setWidth(width),
//              fit: BoxFit.fitWidth,);
//          },
//          imageUrl: url,
//
////      placeholder: (context, url) => CircularProgressIndicator(),
//          errorWidget: (context, url, error) => Icon(Icons.error),
//        )
//    );
//  }

}