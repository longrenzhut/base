

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/BaseUtils.dart';



// class TextView extends StatelessWidget {
//
//   final String data;
//   final int maxLines;
//   final double size;
//   final Color color;
//   final FontWeight weight;
//
//   const TextView(this.data,{Key key, this.maxLines, this.size:14, this.color, this.weight}) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children: [
//       Text(data??"",
//       overflow: TextOverflow.ellipsis,
//       maxLines: maxLines,
//       textScaleFactor:1.0,
//       style: TextStyle(
//         fontSize:  ScreenUtil().setSp(size),
//         color: color,
//         fontWeight: weight,
//       )
//       )
//       ],
//     );
//   }
// }


class TextView extends Text{


  final String data;
  final TextAlign textAlign;


  TextView(this.data,{this.textAlign,double size = 14.0,Color color = Colors.black,FontWeight weight,
    int maxLines:30,double height:1.2}) : super(
      BaseUtils.isEmpty(data)? "": data,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textScaleFactor:1.0,
      softWrap:true,
      textAlign: textAlign,
      style: TextStyle(
        height: height,
        fontSize: size.sp,
        color: color,
        fontWeight: weight,
      )
  );


}
