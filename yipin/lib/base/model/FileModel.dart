/// imageWidth : 1920
/// size : 534874
/// name : "0644124802du2w4u040884.jpg"
/// id : 3523
/// type : "jpg"
/// imageHeight : 1080
/// url : "http://oss.zhongcaicloud.com/oa/M00/00/00/CgACAl-kwWGAIoymAAgpWv1Dtbs928.jpg"

class FileModel {
  int _imageWidth;
  int _size;
  String _name;
  int _id;
  String _type;
  int _imageHeight;
  String _url;
  String _path;

  int get imageWidth => _imageWidth;
  int get size => _size;
  String get name => _name;
  int get id => _id;
  String get type => _type;
  int get imageHeight => _imageHeight;
  String get url => _url;


  set path(String value) {
    _path = value;
  }

  String get path => _path;

  set url(String value) {
    _url = value;
  }

  FileModel({
      int imageWidth, 
      int size, 
      String name, 
      int id, 
      String type, 
      int imageHeight, 
      String url}){
    _imageWidth = imageWidth;
    _size = size;
    _name = name;
    _id = id;
    _type = type;
    _imageHeight = imageHeight;
    _url = url;
}

  FileModel.fromJson(dynamic json) {
    _imageWidth = json["imageWidth"];
    _size = json["size"];
    _name = json["name"];
    _id = json["id"];
    _type = json["type"];
    _imageHeight = json["imageHeight"];
    _url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["imageWidth"] = _imageWidth;
    map["size"] = _size;
    map["name"] = _name;
    map["id"] = _id;
    map["type"] = _type;
    map["imageHeight"] = _imageHeight;
    map["url"] = _url;
    return map;
  }

}