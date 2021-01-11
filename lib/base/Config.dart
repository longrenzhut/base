

class Config{


  //是否是开发
  static  bool DEVELOP = true;
  //是否是测试
  static  bool TEST = false;
  //是否是预发布环境
  static  bool PRE = false;

  /**
   * 开发环境
   */
    static final String JAVA_URL_DEV = "http://dev.buy.zcabc.com/api/v1/boot/";
    static final String PHP_URL_DEV = "http://oa.zhongcaicloud.com/api/v1/micro/";//php
    static final String DEV_UPLOAD = "http://dev.buy.zcabc.com/api/v1/boot/";//文件

  /**
   * 测试环境
   **/
    static final String JAVA_URL_TEST = "http://test.buy.zcabc.com/api/v1/boot/";//java
    static final String PHP_URL_TEST = "";//php
    static final String TEST_UPLOAD = "";//文件

  /**
   * 预发布环境
   **/
    static final String JAVA_URL_PRE = "http://oapre.buy.zcabc.com/api/v1/boot/";//java
    static final String PHP_URL_PRE  = "";//php
    static final String UPLOAD_PRE  = "";//文件

  /**
   * 正式环境
   **/
    static final String JAVA_URL = "http://oa.buy.zcabc.com/api/v1/boot/";//java
    static final String PHP_URL = "";//php
    static final String UPLOAD = "";//文件



  //是否是预发布环境
  static  bool isLogin = false;
  static  String  token = "";
}