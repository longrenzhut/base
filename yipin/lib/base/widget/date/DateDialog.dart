
import '../../base/widget/BaseWidget.dart';

import '../../../base/utils/ImageHelper.dart';
import '../../../base/widget/LinearWidget.dart';
import '../../../base/widget/SuperTextView.dart';
import '../../../base/widget/TextView.dart';
import '../../../common/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../base/extension/WidgetExt.dart';
import '../../../base/extension/ListExt.dart';

class DateDialog extends StatefulWidget {


  static void show(BuildContext context,{
  DateDialogController controller,
    Function(String date) dateCallback

}){

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return DateDialog(controller: controller,dateCallback:dateCallback);
        });
  }

  final DateDialogController controller;
  final Function(String date) dateCallback;

  const DateDialog({Key key, this.controller,this.dateCallback}) : super(key: key);

  @override
  _DateDialogState createState() => _DateDialogState();
}

class _DateDialogState extends BaseWidgetState<DateDialog,DateDialogController> {


  DateTime _dateTime = DateTime.now();

  @override
  DateDialogController getController() => widget.controller?? DateDialogController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return LinearWidget(
      height: 364,
      padding: EdgeInsets.only(left: 16,right: 16,top: 14,bottom: 6),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView("跑动时间",size: 16,color: MyColors.cl_161722,weight: FontWeight.bold,),
            ImageHelper.buildImage("ic_close.png",type: 1,width: 28,height: 28).buildInkWell(() =>
                Navigator.of(context).pop()
            )
          ],
        ),
        Expanded(child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (date) {
              _dateTime = date;
            }),),

        SuperTextView("确定",solid: MyColors.cl_01C6AC,size: 16,
          height: 46,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 8,right: 8),
          color: Colors.white, radius: 8.0,onTap: (){
            Navigator.of(context).pop();
            controller.setValue("${_dateTime.year}-${_change(_dateTime.month)}-${_change(_dateTime.day)}");
            widget.dateCallback?.call(controller.value);
          },)
      ],
    );

  }

  String _change(int value){
    if(value < 10)
      return "0${value}";
    return value.toString();
  }
}

class DateDialogController extends BaseWidgetController{

}

