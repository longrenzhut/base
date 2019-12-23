

import 'package:flutter/material.dart';
import 'package:hydhome/base/adapter/BaseAdapter.dart';
import 'package:hydhome/base/utils/ImageHelper.dart';
import 'package:hydhome/ui/bar/entity/header_entity.dart';

class BannerAdapter extends BaseAdapter<HeaderBannerinfo>{
  @override
  Widget onBindViewHolder(BuildContext context, int index, HeaderBannerinfo model) {
    return ImageHelper.loadWH(model.url,height: 176);
  }

}