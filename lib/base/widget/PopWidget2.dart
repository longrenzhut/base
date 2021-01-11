


import 'package:flutter/material.dart';
import '../controller/BaseController.dart';
import '../painting/MyDecoration.dart';
import '../utils/ImageHelper.dart';
import '../utils/MyColors.dart';
import '../widget/PopWindow.dart';
import '../widget/TextView.dart';


class PopWidget2 extends StatefulWidget {

  final String hint;
  final PopController2 controller;
  final Function(int index,String value) callback;
  final List<String> data;

  const PopWidget2({Key key,
    this.hint:"",
    @required this.controller,
    this.callback,
    this.data
  }) : super(key: key);

  @override
  _PopWidget2LayoutState createState() => _PopWidget2LayoutState();
}

class _PopWidget2LayoutState extends State<PopWidget2> {

  var isSelected = false;

  @override
  Widget build(BuildContext context) {
    isSelected = (widget.controller.value??"").isNotEmpty;

    var color = isSelected? MyColors.cl_00020D : MyColors.cl_9BA0AA;
    var text =  widget.controller.value??widget.hint;


    List<Widget> menuWidgetList = [];
    widget.data.asMap().forEach((key, value) {
      menuWidgetList.add(createItem(key,value));
    });

    return PopWindow(
      controller: widget.controller,
      decoration: MyDecoration.boxDecorationAllRadius(
        stroke: MyColors.cl_E6EAEE,
      ),
      height: 34,
      builder: (context,controller){


        return Column(
          mainAxisSize: MainAxisSize.min,
          children: menuWidgetList,
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
                      widget.controller.index = -1;
                      widget.controller.setValue(null);
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


  Widget createItem(int index,String value){
    return InkWell(
      child:  Container(
        constraints: BoxConstraints(
            minWidth: 130
        ),
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView(value,color: MyColors.cl_7B8290,size: 14,)
          ],
        ),
      ),
      onTap: (){
        widget.callback?.call(index,value);
        setState(() {
          widget.controller.index = index;
          widget.controller.setValue(value);
        });

      },
    );
  }


}

class PopController2 extends PopWindowController with BaseController{

  var index = -1;

  @override
  void setValue(String value) {
    dismiss();
    super.setValue(value);
  }


}
