import 'package:flutter/material.dart';
import 'package:hydhome/base/cache/Cache.dart';
import 'package:hydhome/base/provider/view_state_model.dart';
import 'package:hydhome/generated/i18n.dart';

class LocaleModel extends ViewStateModel {
//  static const localeNameList = ['auto', '中文', 'English'];
  static const localeValueList = ['', 'zh-CN', 'en'];

  //
  static const kLocaleIndex = 'kLocaleIndex';

  int _localeIndex;

  int get localeIndex => _localeIndex;

  Locale get locale {
    if (_localeIndex > 0) {
      var value = localeValueList[_localeIndex].split("-");
      return Locale(value[0], value.length == 2 ? value[1] : '');
    }
    // 跟随系统
    return null;
  }

  LocaleModel() {
    _localeIndex = Cache.instance().getInt(kLocaleIndex) ?? 0;
  }

  switchLocale(int index) {
    _localeIndex = index;
    notifyListeners();
    Cache.instance().putInt(kLocaleIndex, index);
  }

  static String localeName(index, context) {
    switch (index) {
      case 0:
        return '中文';
      case 1:
        return 'English';
      default:
        return '';
    }
  }
}
