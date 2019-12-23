

import 'package:hydhome/base/http/Params.dart';
import 'package:hydhome/base/http/ReqCallBack.dart';
import 'package:hydhome/base/provider/view_state_model.dart';

class PostDetailModel extends ViewStateModel{




  void getPostDet(){
    var params = Params();
    params.put("tid", "tid");
    postP("app/post/detail", params,ReqCallBack(

    ));

  }

}