

import 'package:flutter/material.dart';
import '../utils/BaseUtils.dart';


class TextView extends Text{


  final String data;


  TextView(this.data,{double size = 14.0,Color color = Colors.black,FontWeight weight,int maxLines:4,double height}) : super(
      BaseUtils.isEmpty(data)? "": data,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        fontSize: size,
        color: color,
        fontWeight: weight,

      )
  );
//  TextView(this.data,{double size = 10.0,Color color = Colors.black,FontWeight weight}) : super(
//      controller: TextEditingController(text: BaseUtils.isEmpty(data)? "": data),
//
//      style: TextStyle(
//          fontSize: size,
//          color: color,
//          fontWeight: weight
//      ),
//      readOnly:true,
//      decoration: InputDecoration(
//      focusedBorder: InputBorder.none,
//      border: InputBorder.none,
//      hintStyle: TextStyle(
//          fontSize: size,
//          color: color
//      )
//  )
//  );


}