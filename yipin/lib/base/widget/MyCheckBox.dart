
import 'package:flutter/material.dart';
import '../utils/ImageHelper.dart';
import '../utils/MyColors.dart';


class MyCheckBox extends StatelessWidget {


  final bool value;

  final ValueChanged<bool> onChanged;

  const MyCheckBox({Key key, this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: MyColors.cl_0FB36E,
        focusColor: MyColors.transparent,
        value: value,
        onChanged: onChanged
    );
    // var name = value ? "ic_check_selected.png" : "ic_check.png";
    // return Container(
    //     height: 12,
    //     width: 12,
    //     child: InkWell(
    //       child: ImageHelper.loadAssert(name,height: 12,width: 12),
    //       onTap: (){
    //           onChanged?.call(value);
    //       },
    //     )
    // );
  }
}
