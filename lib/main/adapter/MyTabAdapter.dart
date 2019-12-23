
import 'package:flutter/cupertino.dart';
import 'package:hydhome/base/adapter/BaseGvAdapter.dart';
import 'package:hydhome/base/utils/Adapt.dart';
import 'package:hydhome/base/utils/ImageHelper.dart';
import 'package:hydhome/base/utils/MyColors.dart';
import 'package:hydhome/base/utils/UIHelper.dart';
import 'package:hydhome/base/widget/view/SpaceWidget.dart';


class MyTab{
  String title;
  String resource;
  String resourceSel;
  int flag = 0;



  MyTab(this.title,this.resource,this.resourceSel){

  }

}

class MyTabAdapter extends BaseGvAdapter<MyTab> with ChangeNotifier{


  int position = 0;


  @override
  Widget onBindViewHolder(BuildContext context, int index, MyTab model) {
    var iconName = "";
    if(position == index)
      iconName = model.resourceSel;
    else
      iconName = model.resource;

    Color color =  position != index ?MyColors.cl_B9BEC3: MyColors.cl_1F2736;

    return SizedBox(
      height: Adapt.setHeight(52),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ImageHelper.icon(iconName,width: 26,height: 26),
          SpaceWidget(3),
          Text(model.title,style: UIHelper.textStyle(fontsize: 10,color: color))
        ],
      ),
    );
  }

  @override
  int getSpanCount() {
    return 5;
  }


  @override
  void onClicked(BuildContext context, int index, MyTab model) {
    if(index == position)
      return;
    index = position;

    notifyListeners();

  }

}