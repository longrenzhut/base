
import 'package:base/BaseApp.dart';
import 'package:base/utils/BaseUtils.dart';
import 'package:base/utils/CstColors.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yipin/common/router/MyRouter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  BaseApp.init();
  MyRouter.configureRoutes();
  runApp(ScreenUtilInit(
    designSize: Size(360, 690),
    allowFontScaling: false,
    builder: ()=> MyApp(),
  ));

  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  // if (Platform.isAndroid) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark));
  // }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: BaseUtils.createMaterialColor(Colors.white),//主题色
        primaryColor: Colors.white,//导航栏颜色
        canvasColor: CstColors.bgColor,//画布颜色
      ),

      localeListResolutionCallback: (List<Locale> locales, Iterable<Locale> supportedLocales) {
        return Locale('zh');
      },
      //下拉刷新
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        return locale;
      },

      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      builder: BotToastInit(),
      //       builder: (context, widget) {
      // return MediaQuery(
      // ///Setting font does not change with system font size
      // data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      // child: widget,
      // );
      navigatorObservers: [BotToastNavigatorObserver(),defaultLifecycleObserver],
      localizationsDelegates: [
        RefreshLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: MyRouter.initRouter,
      onGenerateRoute: (settings)=> MyRouter.onGenerateRoute(context,settings),
      onUnknownRoute: (settings)=> MyRouter.onGenerateRoute(context, settings),


    );
  }
}
