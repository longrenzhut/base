





import 'package:flutter/material.dart';
import 'package:hydhome/base/provider/BaseViewModel.dart';
import 'package:web_browser/web_browser.dart';

import '../router/RouterHepler.dart';
import '../utils/MyColors.dart';
import '../view/BasePage.dart';
import '../widget/LineView.dart';
import '../widget/LinearWidget.dart';
import '../widget/MyButton.dart';

class CustomWebPage extends StatefulWidget {

  @override
  _CustomWebPageState createState() => _CustomWebPageState();
}

class _CustomWebPageState extends BasePageState<CustomWebPage,BaseViewModel> {

  @override
  BaseViewModel getViewModel() =>  null;


  @override
  Color get bgColor => MyColors.bgColor;

  String get url{
    var map = arguments;
    if(null != map)
      return map["url"];
    return "";
  }

  String get titles{
    var map = arguments;
    if(null != map)
      return map["titles"];
    return "";
  }

  @override
  Widget getView(BuildContext context) {
    var titleList = titles.split(",");
    return LinearWidget(
      margin: EdgeInsets.all(10.0),
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      bgColor: Colors.white,
      children: [
        LineView(),
        SizedBox(height: 10,),
        MyButton(text: "返回",onPressed: (){
          RouterHepler.pop(context);
        },),
        SizedBox(height: 10,),
        Expanded(child: SafeArea(
          child: WebBrowser(
            initialUrl: url,
          ),
        ))
      ],
    );
  }
}

