import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'base/BaseApp.dart';
import 'base/router/routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  BaseApp.init();
  runApp(MyApp());

  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark));
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,//主题色
          primaryColor: Colors.white,//导航栏颜色
          canvasColor: Colors.white,//画布颜色
          buttonTheme: ButtonThemeData(minWidth: double.infinity, height: double.infinity,
              layoutBehavior:ButtonBarLayoutBehavior.constrained)

      ),

      localeListResolutionCallback: (List<Locale> locales, Iterable<Locale> supportedLocales) {
        return Locale('zh');
      },

      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: (setting)=> Routes.onGenerateRoute(context,setting),

    );
  }
}
