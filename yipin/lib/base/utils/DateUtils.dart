import 'package:flutter_common_utils/date_util.dart';
/*
 * 关于时间工具
 */
class DateUtils {
  // 工厂模式
  factory DateUtils() => _getInstance();

  static DateUtils get instance => _getInstance();
  static DateUtils _instance;

  DateUtils._internal() {
    // 初始化
  }

  static DateUtils _getInstance() {
    if (_instance == null) {
      _instance = new DateUtils._internal();
    }
    return _instance;
  }

  ///将时间日期格式转化为时间戳
  ///2018年12月11日
  ///2019-12-11
  ///2018年11月15 11:14分89
  ///结果是毫秒
  int getTimeStap({formartData: String}) {
    var result = formartData.substring(0, 4) + "-" + formartData.substring(5, 7) + "-" + formartData.substring(8, 10);
    if (formartData.toString().length>=13&&formartData.substring(10, 13) != null) {
      result += "" + formartData.substring(10, 13);
    }
    if (formartData.toString().length>=17&&formartData.toString().substring(14, 16) != null) {
      result += ":" + formartData.substring(14, 16);
    }
    if (formartData.toString().length>=19&&formartData.substring(17, 19) != null) {
      result += ":" + formartData.substring(17, 19);
    }
    var dataTime = DateTime.parse(result);
    print(dataTime.millisecondsSinceEpoch);
    return dataTime.millisecondsSinceEpoch;
  }


  String getChangeTime(String dateStr){
    var dates = dateStr.split(" ");
    if(dates.length != 2)
      return dateStr;
    DateTime dateTime = DateTime.tryParse(dateStr);
    if(DateUtil.isToday(dateTime.microsecond)){
      return "今天 ${dates[1]}";
    }
    if(DateUtil.isYesterday(dateTime,DateTime.now())){
      return "昨天 ${dates[1]}";
    }
    return dateStr;
  }

  String getYearMonthDay(String dateStr){
    var dates = dateStr.split(" ");
    if(dates.length != 2)
      return dateStr;
    return dates[0];
  }

  /// year is today.
  /// 是否是今天.
  static bool isToday(DateTime date, {bool isUtc = false}) {
    if (date == null) return false;
    DateTime old = date;
    DateTime now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    return old.year == now.year && old.month == now.month && old.day == now.day;
  }

  /// year is today.
  /// 是否是是同一天.
  static bool isCommonDay(DateTime oldDate, DateTime newDate,{bool isUtc = false}) {
    if (oldDate == null || newDate == null) return false;
    DateTime old = oldDate;
    DateTime now = isUtc ? newDate.toUtc() : newDate.toLocal();
    return old.year == now.year && old.month == now.month && old.day == now.day;
  }


  // 获取星期
  static String getWeek(DateTime date){
    var week = date.weekday;
    String w = '';
    switch (week.toString()) {
      case '1':
        w = '一';
        break;
      case '2':
        w = '二';
        break;
      case '3':
        w = '三';
        break;
      case '4':
        w = '四';
        break;
      case '5':
        w = '五';
        break;
      case '6':
        w = '六';
        break;
      case '7':
        w = '日';
        break;
    }
    return '周' + w.toString();
  }
}
class TimeData{
  String dataTime;
  int week;
}