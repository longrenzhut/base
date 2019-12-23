
import 'package:flutter/material.dart';
import 'package:hydhome/base/adapter/BaseGvAdapter.dart';
import 'package:hydhome/base/utils/Adapt.dart';

class GridViewZ{

  static Widget build<T>(BaseGvAdapter<T> adapter,{EdgeInsetsGeometry padding = const EdgeInsets.all(0)}){
   return GridView.builder(
        padding: padding,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: adapter.getSpanCount(),
            crossAxisSpacing: Adapt.setWidth(adapter.getHorSpcing()),
            mainAxisSpacing: Adapt.setWidth(adapter.getVerSpcing()),
            childAspectRatio: adapter.getchildAspectRatio()
        ),
        itemCount: adapter.getItemCount(),
        itemBuilder: (BuildContext context, int index) {
          return adapter.onCreateViewHolder(context, index);
        });
  }
}