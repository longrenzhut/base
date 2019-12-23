


import 'package:hydhome/base/http/Params.dart';
import 'package:hydhome/base/http/ReqCallBack.dart';
import 'package:hydhome/base/provider/view_state_list_model.dart';
import 'package:hydhome/ui/bar/entity/header_entity.dart';
import 'package:hydhome/ui/bar/entity/post_entity.dart';

class PostListModel extends ViewStateListModel<PostEntity>{

  HeaderEntity _headerEntity;

  HeaderEntity get headerEntity => _headerEntity;

  @override
  void loadData({int pageNum}) {
    var param1 = Params();
    param1.put("current", pageNum);
    param1.put("type", 0);

    var _reqCallBack =  ReqCallBack(
        isList: true,
        onListSuccess: (result) {
          var data = result.map<PostEntity>((item)=>PostEntity.fromJson(item)).toList();
          if(pageNum == 1){
            refreshCompleted(data);
          }
          else{
            loadMoreCompleted(data);
          }
        },
        onError: loadFailed

    );

    if(pageNum == 1) {
      var request1 = requestP("app/post/getList", param1);

      var param2 = Params();
      var request2 = requestP("app/banner/index", param2);
      zip([
       request2, request1,
      ], [

        ReqCallBack(
            onSuccess: (result) {
              _headerEntity = HeaderEntity.fromJson(result);
            },
            onError: loadFailed
        ),
        _reqCallBack,
      ]);
    }
    else{

      postP("app/post/getList", param1, _reqCallBack);
    }
  }

}








