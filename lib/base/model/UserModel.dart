import 'dart:convert';
import 'dart:io';


/// id : 2
/// deleteTag : 0
/// createBy : "1"
/// createTime : "2020-11-10 14:47:18"
/// updateBy : "1"
/// updateTime : "2020-11-10 14:47:21"
/// idStr : "2"
/// supId : 227
/// account : "cg002"
/// password : "OyUHgt21gTP2/5uFgbKZtq=="
/// phone : "15088765390"
/// tocken : null
/// idsList : null

class UserModel {
  int _id;
  int _deleteTag;
  String _createBy;
  String _createTime;
  String _updateBy;
  String _updateTime;
  String _idStr;
  String _supName;
  int _supId;
  String _account;
  String _password;
  String _phone;
  String _codingPhone;
  String _token;

  int get id => _id;
  int get deleteTag => _deleteTag;
  String get createBy => _createBy;
  String get createTime => _createTime;
  String get updateBy => _updateBy;
  String get updateTime => _updateTime;
  String get idStr => _idStr;
  String get supName => _supName;
  int get supId => _supId;
  String get account => _account;
  String get password => _password;
  String get phone => _phone;
  String get token => _token;
  String get codingPhone => _codingPhone;


  set id(int value) {
    _id = value;
  }

  set token(value){
    _token = value;
  }

  set codingPhone(value){
    _codingPhone = value;
  }


  UserModel.fromJson(dynamic json) {
    _id = json["id"];
    _deleteTag = json["deleteTag"];
    _createBy = json["createBy"];
    _createTime = json["createTime"];
    _updateBy = json["updateBy"];
    _updateTime = json["updateTime"];
    _idStr = json["idStr"];
    _supId = json["supId"];
    _supName = json["supName"];
    _account = json["account"];
    _password = json["password"];
    _phone = json["phone"];
    _token = json["token"];
    _codingPhone = json["codingPhone"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["deleteTag"] = _deleteTag;
    map["createBy"] = _createBy;
    map["createTime"] = _createTime;
    map["updateBy"] = _updateBy;
    map["updateTime"] = _updateTime;
    map["idStr"] = _idStr;
    map["supId"] = _supId;
    map["account"] = _account;
    map["password"] = _password;
    map["phone"] = _phone;
    map["token"] = _token;
    map["codingPhone"] = _codingPhone;
    return map;
  }

  set deleteTag(int value) {
    _deleteTag = value;
  }

  set createBy(String value) {
    _createBy = value;
  }

  set createTime(String value) {
    _createTime = value;
  }

  set updateBy(String value) {
    _updateBy = value;
  }

  set updateTime(String value) {
    _updateTime = value;
  }

  set idStr(String value) {
    _idStr = value;
  }

  set supId(int value) {
    _supId = value;
  }

  set account(String value) {
    _account = value;
  }

  set password(String value) {
    _password = value;
  }

  set phone(String value) {
    _phone = value;
  }

}