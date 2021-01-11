

import 'package:flutter/material.dart';
import '../adapter/BaseAdapter.dart';
import '../extension/ListExt.dart';
import '../painting/MyDecoration.dart';
import '../utils/ImageHelper.dart';
import '../utils/MyColors.dart';
import '../utils/WidgetUtils.dart';
import '../widget/LinearWidget.dart';
import '../widget/PopWindow.dart';
import '../widget/TextView.dart';

class ItemScreenLayout<T> extends StatefulWidget {

  final String hint;
  final ScreenController controller;
  final int type;
  final List<String> menuItems;
  final List<T> data;
  final Future Function() future;
  final Function(int index,T model) callback;

  const ItemScreenLayout({Key key, this.hint:"",this.type: 0,
    this.data,
    @required this.menuItems,
    this.future,
    this.controller,
    this.callback
  }) : super(key: key);

  @override
  _ItemScreenLayoutState<T> createState() => _ItemScreenLayoutState<T>();
}

class _ItemScreenLayoutState<T> extends State<ItemScreenLayout<T>> {

  var isSelected = false;
  String selectedItem = null;

  @override
  Widget build(BuildContext context) {
    isSelected = (selectedItem??"").isNotEmpty;

    var color = isSelected? MyColors.cl_00020D : MyColors.cl_9BA0AA;
    var text =  selectedItem??widget.hint;


    List<Widget> menuWidgetList = [];
    if(widget.menuItems.isNotEmptyOrNull()){
      widget.menuItems.asMap().forEach((key, value) {
        var model = widget.data.isNotEmptyOrNull()? widget.data[key] : null;
        menuWidgetList.add(createItem(key,widget.menuItems[key],model));
      });

    }
    return PopWindow(
      controller: widget.controller,
      future: widget.future,
      decoration: MyDecoration.boxDecorationAllRadius(
        stroke: MyColors.cl_E6EAEE,
      ),
      height: 34,
      builder: (context,controller){

//        return WidgetUtils.buildList(
//          adapter: BaseAdapter<String>(
//            data: widget.menuItems,
//            builder: (context,index,model){
//              return IntrinsicWidth(
//                stepHeight: 20,
//                stepWidth: 120,
//                child: Container(
//                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
//                  child: TextView(model,color: MyColors.cl_7B8290,size: 14,),
//                ),
//              );
//            }
//          )
//        );
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
                      selectedItem = null;
                      widget.controller.model = null;
                    });
                  },
                )
              ],
            ),
//            Offstage(
//              offstage: isSelected,
//              child:  ImageHelper.loadAssert("ic_to_bottom.png",width: 10,height: 6),
//            ),
//            Offstage(
//                offstage: !isSelected,
//                child: InkWell(
//                  child: ImageHelper.loadAssert("ic_close.png",width: 20,height: 12,),
//                  onTap: (){
//                    setState(() {
//                      selectedItem = null;
//                      widget.controller.model = null;
//                    });
//                  },
//                )
//            ),
          ],
        ),
      ),
    );
  }


  Widget createItem(int index,String menu,T model){
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        child: TextView(menu,color: MyColors.cl_7B8290,size: 14,),
      ),
      onTap: (){
        widget.callback?.call(index,model);
        setState(() {
          selectedItem = menu;
          widget.controller.model = model;
        });

      },
    );
  }


}

class ScreenController<T> extends PopWindowController{

  T _model;


  T get model => _model;

  set model(T value) {
    dismiss();
    _model = value;

  }


}
