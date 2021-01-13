import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../provider/BaseViewModel.dart';
import '../utils/MyColors.dart';
import '../view/BasePage.dart';

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
    return  WebView(
            initialUrl: url,  //需要打开的url
            //是否支持js 默认是不支持的，
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              //页面加载的时候可以获取到controller可以用来reload等操作
            },
            //加载js方法到页面内，js通过此来调用flutter的方法
            // javascriptChannels: _loadJavascriptChannel(context),
            onPageStarted: (String url) {
            },
            onPageFinished: (String url) {

            },
            //拦截页面url
            // navigationDelegate: (NavigationRequest request) {
            //   if (request.url.startsWith('alipays:') ||
            //       request.url.startsWith('weixin:')) {
            //     return NavigationDecision.prevent;
            //   }
            //   return NavigationDecision.navigate;
            // },


    );
  }
}

