
import 'package:open_settings/open_settings.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';

import 'LaunchUtils.dart';

class PermissionUtils {

  static request(Permission permission,Function(bool isGranted) callback) async{
    var status = await permission.status;
    if (status.isGranted) {
      callback?.call(true);
      return;
    }

    var req = await  permission.request();
    if (req.isGranted) {
      callback?.call(true);
    }
    else{
      if(req.isPermanentlyDenied){
        OpenSettings.openAppSetting();
      }
      else{
        callback?.call(false);
      }
    }
  }



}
