import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydhome/base/provider/provider_widget.dart';
import 'package:hydhome/base/router/routes.dart';
import 'package:hydhome/base/view_model/locale_model.dart';
import 'package:hydhome/generated/i18n.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base/cache/Cache.dart';
import 'main/Application.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Application.init();
  await Cache.initSp();
  runApp( App()
//        MaterialApp(
//            theme: ThemeData(
//              primarySwatch: Colors.green,//主题色
//              primaryColor: Colors.white,//导航栏颜色
//              canvasColor: Colors.white,//画布颜色
//              buttonTheme: ButtonThemeData(minWidth: double.minPositive, height: double.minPositive),
//
//            ),
//            home: TabPage(),
//          onGenerateRoute: Application.router.generator,
//        ),
  );

  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ProviderWidget<LocaleModel>(
      model: LocaleModel(),
      builder: (context,localeModel,child){
        return  RefreshConfiguration(
          hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,//主题色
              primaryColor: Colors.white,//导航栏颜色
              canvasColor: Colors.white,//画布颜色
              buttonTheme: ButtonThemeData(minWidth: double.minPositive, height: double.minPositive),

            ),
            locale: localeModel.locale,
            localizationsDelegates: const [
              S.delegate,
              RefreshLocalizations.delegate, //下拉刷新
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: S.delegate.supportedLocales,
            onGenerateRoute: Application.router.generator,
            initialRoute: Routes.splash,
          ),
        );
      }
    );

  }
}



