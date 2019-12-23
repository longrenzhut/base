
import 'package:flutter/material.dart';
import 'package:hydhome/base/adapter/BaseAdapter.dart';
class BasePvAdapter  extends BaseAdapter<Widget>{

  BasePvAdapter({List<Widget> data,bool isClick,
    Function(int index,Widget model) onItemClick }):super(data: data,isClick : isClick = false,
  onItemClick: onItemClick);

  @override
  Widget onBindViewHolder(BuildContext context, int index, Widget model) {
    return model;
  }

}