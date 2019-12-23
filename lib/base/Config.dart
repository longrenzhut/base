

class Config{


  //是否是开发
  static final bool DEVELOP = false;
  //是否是测试
  static final bool TEST = true;
  //是否是预发布环境
  static final bool PRE = false;

  /**
   * 开发环境
   */
    static final String JAVA_URL_DEV = "";//java
    static final String PHP_URL_DEV = "http://dev.waterhome.zcabc.com/api/";//php
    static final String DEV_UPLOAD = "http://dev.waterhome.zcabc.com/api/";//文件

  /**
   * 测试环境
   **/
    static final String JAVA_URL_TEST = "";//java
    static final String PHP_URL_TEST = "http://test.waterhome.zcabc.com/api/";//php
    static final String TEST_UPLOAD = "http://test.waterhome.zcabc.com/api/";//文件

  /**
   * 预发布环境
   **/
    static final String JAVA_URL_PRE = "";//java
    static final String PHP_URL_PRE  = "https://water-pre.zhongcaicloud.com/api/";//php
    static final String UPLOAD_PRE  = "https://water-pre.zhongcaicloud.com/api/";//文件

  /**
   * 正式环境
   **/
    static final String JAVA_URL = "";//java
    static final String PHP_URL = "https://water.zhongcaicloud.com/api/";//php
    static final String UPLOAD = "https://water.zhongcaicloud.com/api/";//文件


  //是否是预发布环境
  static final bool isLogin = false;
  static final String  token = "";
}