


import 'package:flutter/material.dart';
import '../adapter/BaseAdapter.dart';
import '../controller/BaseController.dart';
import '../painting/MyDecoration.dart';
import '../utils/ImageHelper.dart';
import '../utils/MyColors.dart';
import '../utils/WidgetUtils.dart';
import '../widget/PopWindow.dart';
import '../widget/TextView.dart';

class PopModel{

  String _value;

  String get value => null;



}

class PopWidget<T extends PopModel> extends StatefulWidget {

  final String hint;
  final PopController controller;
  final Future Function() future;
  final double popWidth;
  final Function(int index,T model) callback;
  final List<T> Function() dataBuilder;

  const PopWidget({Key key,
    this.hint:"",
    @required this.controller,
    this.future,
    this.callback,
    this.popWidth:130,
    this.dataBuilder
  }) : super(key: key);

  @override
  _PopWidgetLayoutState<T> createState() => _PopWidgetLayoutState<T>();
}

class _PopWidgetLayoutState<T extends PopModel> extends State<PopWidget<T>> {

  var isSelected = false;

  List<T> data;
  @override
  Widget build(BuildContext context) {
    isSelected = (widget.controller.value??"").isNotEmpty;

    var color = isSelected? MyColors.cl_00020D : MyColors.cl_9BA0AA;
    var text =  widget.controller.value??widget.hint;
    return PopWindow(

      controller:  widget.controller,
      future: widget.future,
      decoration: MyDecoration.boxDecorationAllRadius(
        stroke: MyColors.cl_E6EAEE,
      ),
      height: 34,
      popWidth: widget.popWidth,
      builder: (context,controller){

        // List<Widget> menuWidgetList = [];
        data = widget.dataBuilder();
        // data.asMap().forEach((key, value) {
        //   menuWidgetList.add(createItem(key,value));
        // });

        // return Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: menuWidgetList,
        // );
       return Container(
         height: (data?.length??0) < 10 ? (data?.length??0) * 43 : 10*43.0,
         child:  WidgetUtils.buildList(
             adapter: BaseAdapter<T>(
                 data: data,
                 builder: (context,index,model){
                   return Container(
                     padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                     child: TextView(model.value,color: MyColors.cl_7B8290,size: 14,),
                   );
                 },
                 onItemClick: (context,index,model){
                   widget.callback?.call(index,model);
                   setState(() {
                     widget.controller.model = model;
                   });
                 }
             )
         ),
       );

      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 10),
        constraints:BoxConstraints(
          minHeight: 34,
        ),
        child: Row(
          children: [
            ConstrainedBox(
              constraints:BoxConstraints(
                minWidth: 120,
              ),
              child: TextView(text,color: color,size: 14,),
            ),
            SizedBox(width: 10,),
            IndexedStack(
              alignment: Alignment.centerLeft,
              index: isSelected? 1 : 0,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.centerRight,
                  child: ImageHelper.loadAssert("ic_to_bottom.png",width: 10,height: 6),
                ),
                InkWell(
                  child: ImageHelper.loadAssert("ic_close.png",width: 16,height: 16,),
                  onTap: (){
                    setState(() {
                      widget.controller.model = null;
                    });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget createItem(int index,T model){
    return InkWell(
      child: Container(
        constraints: BoxConstraints(
          minWidth: 130
        ),
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView(model.value,color: MyColors.cl_7B8290,size: 14,)
          ],
        ),
      ),
      onTap: (){
        widget.callback?.call(index,model);
        setState(() {
          widget.controller.model = model;
        });

      },
    );
  }


}

class PopController<T extends PopModel> extends PopWindowController with BaseController{

  T _model;


  T get model => _model;

  set model(T value) {
    setValue(value?.value??null);
    _model = value;
  }

  @override
  void setValue(String value) {
    dismiss();
    super.setValue(value);
  }

  @override
  void reset() {
    model = null;
    super.reset();
  }


}
