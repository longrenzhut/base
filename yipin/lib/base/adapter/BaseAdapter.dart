
import '../utils/MyColors.dart';
import 'package:flutter/material.dart';

 class BaseAdapter<T>{

  List<T> data;

  Widget header;

  bool isClick = true;
  double divider;
  Color dividerColor = MyColors.cl_A5AAB4;

  Function(BuildContext context,int index,T model) onItemClick;

  Widget Function(BuildContext context,int index, T model) builder;

  BaseAdapter({
    this.data,
    this.isClick = true,
    this.onItemClick,
    this.builder,
    this.header,
    this.divider = 0,
    this.dividerColor,
  });


  void setOnItemCallback(Function(BuildContext context,int index,T model) onItemClick){
    this.onItemClick = onItemClick;
  }


  BaseAdapter<T> setDatas(List<T> datas){
    this.data = datas;

    return this;
  }

  List<T> getDatas()=> data;

  int getHeaderCount(){

    return (null == header ? 0 : 1);
  }

  int getItemCount(){
    int count = (null == data ? 0 : data.length) + getHeaderCount();
    return count;
  }

  Widget onBindViewHolderHeader(BuildContext context, int index){

    return header;
  }

  Widget onCreateViewHolder(BuildContext context, int index) {
    if(index < getHeaderCount()){
      return onBindViewHolderHeader(context,index);
    }

    T model = data[index - getHeaderCount()];
    return !isClick?
    builder(context,index,model):
//        Ink(
//          width: double.minPositive,
//          color: MyColors.white,
//            child:
            InkWell(

//      customBorder:ContinuousRectangleBorder(
//        side: BorderSide(
//          color: Colors.white,
//          style: BorderStyle.solid,
//        )
//      ),
              onTap: (){
                if(null != onItemClick)
                  onItemClick(context,index,model);
                else
                  onItemClicked(context,index,model);
              },
              child: builder(context,index,model),
//            ),
        );

  }

  void onItemClicked(BuildContext context, int index,T model){

  }



}