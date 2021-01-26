import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'PermissionUtils.dart';

class LaunchUtils {

  static open(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static call(String phone){
    PermissionUtils.request(Permission.phone,(isExit){
      if(isExit){
        open("tel:${phone}");
      }
    });
  }


}
