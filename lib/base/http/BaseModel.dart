/// data : {"subMsg":"操作成功","subCode":10000,"result":"mixed"}
/// meta : {"code":200,"msg":"请求成功"}

class BaseModel{
  Data _data;
  Meta _meta;

  Data get data => _data;
  Meta get meta => _meta;


  BaseModel.fromJson(dynamic json) {
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    if (_meta != null) {
      map["meta"] = _meta.toJson();
    }
    return map;
  }

}

/// code : 200
/// msg : "请求成功"

class Meta {
  int _code;
  String _msg;

  int get code => _code;
  String get msg => _msg;

  Meta({
      int code,
      String msg}){
    _code = code;
    _msg = msg;
}

  Meta.fromJson(dynamic json) {
    _code = json["code"];
    _msg = json["msg"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["msg"] = _msg;
    return map;
  }

}

/// subMsg : "操作成功"
/// subCode : 10000
/// result : "mixed"

class Data {
  String _subMsg;
  int _subCode;
  dynamic _result;

  String get subMsg => _subMsg;
  int get subCode => _subCode;
  dynamic get result => _result;


  Data.fromJson(dynamic json) {
    _subMsg = json["subMsg"];
    _subCode = json["subCode"];
    _result = json["result"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["subMsg"] = _subMsg;
    map["subCode"] = _subCode;
    map["result"] = _result;
    return map;
  }

}