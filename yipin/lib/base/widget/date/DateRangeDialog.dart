
import '../../../base/adapter/BaseAdapter.dart';
import '../../../base/painting/MyDecoration.dart';
import '../../../base/utils/CstColors.dart';
import '../../../base/utils/DateUtils.dart';
import '../../../base/utils/ImageHelper.dart';
import '../../../base/utils/WidgetUtils.dart';
import '../../../base/widget/LinearWidget.dart';
import '../../../base/widget/TextView.dart';
import '../../../common/MyColors.dart';
import 'package:flutter/material.dart';
import '../../../base/view/BaseWidget.dart';
import '../../../base/extension/WidgetExt.dart';

class DateRangeDialog extends StatefulWidget {

  final DateTime initialStartTime;
  final DateTime initialEndTime;
  final DateRangeController controller;
  final Function(String start,String end) callback;

  static Future show(BuildContext context,{
    DateTime initialStartTime,
    DateTime initialEndTime,
    DateRangeController controller,
    Function(String start,String end) callback

  }) {
    return showModalBottomSheet(context: context,
        isScrollControlled: true,
        builder: (context){

          return DateRangeDialog(initialStartTime:initialStartTime,initialEndTime: initialEndTime,
              controller: controller,callback:callback);
        }
    );
  }

  const DateRangeDialog({Key key, this.initialStartTime,
    this.initialEndTime,
    this.callback,
    this.controller
  }) : super(key: key);

  @override
  _DateRangeDialogState createState() => _DateRangeDialogState();
}

class _DateRangeDialogState extends BaseWidgetState<DateRangeDialog,DateRangeController> {

  @override
  DateRangeController getController() =>  widget.controller??DateRangeController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.initialStartTime = widget.initialStartTime??DateTime.now();
    controller.startTime = widget.initialStartTime??DateTime.now();
    controller.endTime = widget.initialEndTime??DateTime.now();
    controller.initCtr();
  }

  @override
  Widget build(BuildContext context) {
    return LinearWidget(
      padding: EdgeInsets.symmetric(vertical: 20),
      bgColor: Colors.white,
      height: 585,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              TextView("时间筛选",size: 16,color: MyColors.cl_161722,).buildExpanded(),
              ImageHelper.buildImage("ic_close.png",width: 28,height: 28,type: 1).buildInkWell((){
                Navigator.of(context).pop();
              })
            ],
          ),
        ),
        SizedBox(height: 20,),
        Container(
          padding: EdgeInsets.only(left: 11,right: 11),
          child:  Row(
            children: List.generate(controller.weekDay.length, (index){
              return Expanded(child: Center(
                child: TextView(controller.weekDay[index],size: 14,color: MyColors.cl_7B8290,),
              ));
            }).toList(),
          ),
        ),
        WidgetUtils.buildPageView(
            pageSnapping: false,
            controller: controller.pvCtr,
            scrollDirection: Axis.vertical,
            adapter: BaseAdapter<String>(
                count: 6000,
                isClick: false,
                builder: (context,index,model){

                  List<int> yearMonth = controller.getYearMonthByIndex(index);

                  var fistDay = DateTime(yearMonth[0],yearMonth[1],1);
                  var lastDay = DateUtils.lastDayOfMonth(fistDay);
                  var diff = fistDay.weekday == 7 ? 0 : fistDay.weekday - 1;
                  List<DateTime> data = List.generate(lastDay.day + diff, (index) {
                    if(index <= diff)
                      return null;
                    return DateTime(fistDay.year,fistDay.month,index - diff);
                  });

                  return LinearWidget(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    padding: EdgeInsets.only(left: 11,right: 11),
                    children: [
                      SizedBox(height: 20,),
                      TextView("${yearMonth[0]}年${yearMonth[1]}月",size: 14,color: MyColors.cl_161722,),
                      SizedBox(height: 20,),
                      WidgetUtils.buildGrid(
                          crossAxisSpacing:0,
                          crossAxisCount:7,
                          physics:NeverScrollableScrollPhysics(),
                          childAspectRatio: (MediaQuery.of(context).size.width/10.0)/40,
                          adapter: BaseAdapter<DateTime>(
                              isClick: false,
                              data: data,
                              builder: (context,index,model){
                                if(null == model)
                                  return SizedBox.shrink();

                                BoxDecoration decoration;

                                if(DateUtils.isCommonDay(model, controller.startTime) ||
                                    DateUtils.isCommonDay(model, controller.endTime))
                                {
                                  decoration = MyDecoration.buildShape(radius: 8,solid: MyColors.cl_01C6AC);
                                }
                                else if(null != controller.endTime){
                                  if(model.isAfter(controller.startTime) && model.isBefore(controller.endTime))
                                    decoration = MyDecoration.buildShape(solid: MyColors.cl_C8FAF3);
                                  else
                                    decoration = null;
                                }
                                else{
                                  decoration = null;
                                }
                                return Container(
                                  decoration: decoration,
                                  alignment: Alignment.center,
                                  child: TextView(DateUtils.isToday(model) ? "今天" :model?.day?.toString()??"",size: 16,color: MyColors.cl_161722,
                                    weight: FontWeight.w400,),
                                ).buildInkWell((){
                                  if(controller.startTime != null && controller.endTime != null){
                                    controller.startTime = model;
                                    controller.endTime = null;
                                    controller.notifyUI();
                                  }
                                  else if(controller.startTime != null && controller.endTime == null){
                                    if(model.isBefore(controller.startTime)){
                                      controller.endTime = controller.startTime;
                                      controller.startTime = model;
                                    }
                                    else{
                                      controller.endTime = model;
                                    }
                                    controller.notifyUI();
                                  }
                                });
                              }
                          )),
                      // SizedBox(height: 50,),
                      Spacer(),
                      Container(
                        height: 10,
                        color: CstColors.bgColor,
                      ),
                    ],

                  );
                }
            )
        ).buildExpanded(),
        Container(
          height: 46,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 4,right: 4),
          decoration: MyDecoration.buildShape(radius: 8,solid: MyColors.cl_01C6AC),
          child: TextView("确定",size: 16,color: Colors.white,),
        ).buildInkWell((){
          widget.callback?.call(controller.startStr,controller.endStr);
          Navigator.of(context).pop(1);
        })
      ],
    );
  }
}


class DateRangeController extends BaseWidgetController{
  PageController pvCtr;

  DateTime initialStartTime;
  DateTime _startTime;
  DateTime _endTime;


  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;

  String startStr;
  String endStr;

  set startTime(DateTime value) {
    _startTime = value;
    if(null != value)
      startStr = "${value.year}-${change(value.month)}-${change(value.day)}";
    else
      startStr = null;
  }

  String change(int num){
    return num < 10 ? "0${num}" : num.toString();
  }


  set endTime(DateTime value) {
    _endTime = value;
    if(null != value)
      endStr = "${value.year}-${change(value.month)}-${change(value.day)}";
    else
      endStr = null;
  }

  int curYear;
  int curMonth;
  int curDay;


  final int count = 3000;


  initCtr(){
    pvCtr = PageController(initialPage: count,keepPage: false);
    curYear = initialStartTime.year;
    curMonth = initialStartTime.month;
    curDay = initialStartTime.day;

  }


  List<String> weekDay = ["日","一","二","三","四","五","六"];

  List<int> getYearMonthByIndex(int index){
    var diff = index - count;

    if(diff > 0) {
      var total = curMonth + diff;
      if (total <= 12) {
        return [curYear, curMonth + diff];
      }
      else {
        int newYear = curYear + diff ~/ 12;
        int newMonth = curMonth + diff % 12;

        return [newYear, newMonth];
      }
    }
    else{
      var total = curMonth + diff;
      if (total >=1) {
        return [curYear, curMonth + diff];
      }
      else {
        int newYear = curYear + diff ~/ 12;
        int newMonth = curMonth + diff % 12;

        return [newYear, newMonth];
      }
    }
  }
}

