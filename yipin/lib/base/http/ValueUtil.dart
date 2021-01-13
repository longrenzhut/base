import 'package:dio/dio.dart';
import '../http/BaseModel.dart';
import '../http/ReqCallBack.dart';
import '../utils/ToastUtil.dart';

class ValueUtil {


  static int fromJson(Response response, ReqCallBack callBack) {

    int code = 1;

    if(response.statusCode != 200){//服务器错误
      code = -1;
      if(callBack?.isToast == true)
        ToastUtil.showToast(response.statusMessage);
      callBack?.onReqError(response.statusMessage);

    }
    else{
      BaseModel model = BaseModel.fromJson(response.data);
      if(model.meta.code == 200){
        if(model.data.subCode == 10000) {
          callBack?.onReqSuccess(model.data.result);
        }
        else{
          code = model.data.subCode;
          //逻辑业务处理提示
          if(callBack?.isToast == true)
            ToastUtil.showToast(model.data.subMsg);
          callBack?.onReqFailed(model.data.subCode,model.data.subMsg);
        }
      }
      else{
        code = model.data.subCode;
        //网络问题错误
        if(callBack?.isToast == true)
          ToastUtil.showToast(model.meta.msg);
        callBack?.onReqFailed(model.meta.code,model.meta.msg);

      }
    }
    callBack?.onReqCompleted();
    return code;
  }

}
