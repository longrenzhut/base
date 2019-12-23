

import 'package:flutter/material.dart';
import 'package:hydhome/base/adapter/BaseAdapter.dart';
import 'package:hydhome/base/utils/Adapt.dart';

class ListZ{

  static Widget build<T>(BaseAdapter<T> adapter,{EdgeInsetsGeometry padding  = const EdgeInsets.all(0),
    bool shrinkWrap: false,
    ScrollController controller,
    Widget header,
    List<Widget> headers,
  }){


    if(null != header)
      adapter.setHeader(header);

    if(null != headers)
      adapter.setHeaders(headers);

    return ListView.separated(
        padding: padding,
        controller: controller,
        shrinkWrap: shrinkWrap,
        itemCount: adapter.getItemCount(),
        itemBuilder: (BuildContext context, int index) {
          return adapter.onCreateViewHolder(context, index);
        },
        separatorBuilder: (BuildContext context, int index) {
            return  Divider(
                height:  Adapt.setWidth(adapter.getDividerHeight()),
                color: adapter.getDividerColor());
        }
    );
  }

}