
import 'package:flutter/material.dart';

abstract class BaseAdapter<T>{

  List<T> data;

  List<Widget> _headers;

  bool isClick = true;

  Function(int index,T model) onItemClick;

  BaseAdapter({
    this.data,
    this.isClick = true,
    this.onItemClick,
  }) {
  }

  void setHeaders(List<Widget> _headers){
    this._headers = _headers;
  }

  void setHeader(Widget _header){
    if(_headers == null)
      this._headers = [];
    this._headers.clear();
    this._headers.add(_header);
  }

  void setOnItemCallback(Function(int index,T model) onItemClick){
    this.onItemClick = onItemClick;
  }


  BaseAdapter<T> setDatas(List<T> datas){
    this.data = datas;

    return this;
  }

  List<T> getDatas()=> data;

  int getHeaderCount(){

    return (null == _headers ? 0 : _headers.length);
  }

  int getItemCount(){
    int count = (null == data ? 0 : data.length) + getHeaderCount();
    return count;
  }

  Widget onBindViewHolderHeader(BuildContext context, int index){

    return _headers[index];
  }

  Widget onCreateViewHolder(BuildContext context, int index) {
    if(index < getHeaderCount()){
      return onBindViewHolderHeader(context,index);
    }

    T model = data[index - getHeaderCount()];
    return !isClick?
    onBindViewHolder(context,index,model):
    InkWell(
      onTap: (){
        if(null != onItemClick)
          onItemClick(index,model);
        else
          onItemClicked(context,index,model);
      },
      child: onBindViewHolder(context,index,model),
    );
  }

  void onItemClicked(BuildContext context, int index,T model){

  }


  Widget onBindViewHolder(BuildContext context, int index,T model);

  double getDividerHeight(){
    return 0;
  }

  Color getDividerColor(){
    return Colors.transparent;
  }

}