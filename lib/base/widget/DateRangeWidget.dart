

import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter/material.dart';
import '../provider/BaseViewModel.dart';

import '../controller/BaseController.dart';
import '../painting/MyDecoration.dart';
import '../utils/BaseUtils.dart';
import '../utils/ImageHelper.dart';
import '../utils/MyColors.dart';
import '../view/BasePage.dart';
import '../widget/TextView.dart';

class DateRangeWidget extends StatefulWidget {

  final String hint;
  final bool isMin;
  final void Function(String start,String end) onDateRangeSelected;
  final DateRangeController controller ;

  const DateRangeWidget({Key key, this.hint, this.controller,this.onDateRangeSelected,this.isMin : true}) : super(key: key);

  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends BasePageState<DateRangeWidget,DateRangeController> {

  @override
  DateRangeController getViewModel() =>  widget.controller??DateRangeController();

  @override
  bool get isWidget => true;

  @override
  Color get bgColor => MyColors.transparent;

  @override
  Widget getView(BuildContext context) {


    var color = viewModel.isSelected? MyColors.cl_00020D : MyColors.cl_9BA0AA;
    var text =  viewModel.value??widget.hint;

    var inkWell =  InkWell(
      child: Container(
        decoration: MyDecoration.boxDecorationAllRadius(
          stroke: MyColors.cl_E6EAEE,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 10),
        constraints:BoxConstraints(
          minHeight: 34,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints:BoxConstraints(
                minWidth: 122,
              ),
              child: TextView(text,color: color,size: 14,),
            ),
            SizedBox(width: 10,),
            IndexedStack(
              index: !viewModel.isSelected? 0: 1,
              children: [
                ImageHelper.loadAssert("ic_date.png",width: 16,height: 16),
                InkWell(
                  child: ImageHelper.loadAssert("ic_close.png",width: 16,height: 16,),
                  onTap: () async {

                    viewModel?.setRangeDate(null, null);
                  },
                )
              ],
            )
          ],
        ),
      ),
      onTap: () async {

        final List<DateTime> picked = await DateRagePicker.showDatePicker(
          context: context,
          initialFirstDate: DateTime.now(),
          initialLastDate: DateTime.now(),
          firstDate: DateTime(1900, 1),
          lastDate: DateTime(2200, 12),
        );
        if (picked != null && picked.length == 2) {
          viewModel?.setRangeDate(picked[0], picked[1]);
          widget.onDateRangeSelected?.call(viewModel?.startDate,viewModel?.endDate);
        }
      },
    );
    return inkWell;
  }

}

class DateRangeController extends BaseViewModel with BaseController{


  String _startDate;
  String _endDate;


  String get startDate => _startDate;

  set startDate(String value) {
    _startDate = value;
  }

  void setRangeDate(DateTime start,DateTime end){
    if(null == start || end == null){
      _startDate = null;
      _endDate = null;
      setValue(null);
    }
    else{
      _startDate = "${start.year}-${getZStr(start.month)}-${getZStr(start.day)}";
      _endDate = "${end.year}-${getZStr(end.month)}-${getZStr(end.day)}";
      setValue("${start.year}/${getZStr(start.month)}/${getZStr(start.day)} - ${end.year}/${getZStr(end.month)}/${getZStr(end.day)}");
    }
  }

  String getZStr(int value){
    return value < 10 ? "0${value}" : "${value}";
  }

  @override
  void setValue(String value) {
    super.setValue(value);
    isSelected = !BaseUtils.isEmpty(value);
    notifyWidget();
  }

  bool _isSelected = false;

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }

  String get endDate => _endDate;

  set endDate(String value) {
    _endDate = value;
  }

  @override
  void reset() {
    setRangeDate(null,null);
  }

}

