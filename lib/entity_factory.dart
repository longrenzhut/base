import 'package:hydhome/ui/bar/entity/header_entity.dart';
import 'package:hydhome/ui/bar/entity/post_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "HeaderEntity") {
      return HeaderEntity.fromJson(json) as T;
    } else if (T.toString() == "PostEntity") {
      return PostEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}