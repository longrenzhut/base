
import '../widget/ptr/PtrWidget.dart';

import 'BaseViewModel.dart';


abstract class ListViewModel<T> extends BaseViewModel{


  static const int pageNumFirst = 1;

  static const int pageSize = 10;

  PtrController _refreshController = PtrController(initialRefresh: false);

  PtrController get refreshController => _refreshController;

  /// 当前页码
  int _currentPageNum = pageNumFirst;

  //数据源
  List<T> list = [];

  List<T> data;

  Future refresh() async {
    _currentPageNum = pageNumFirst;
    data = null;
    var code = await loadData(pageNum: pageNumFirst);
    if(code == 1) {
      list.clear();
      if (data.isEmpty) {
        refreshController.refreshCompleted(resetFooterState: true);
      } else {
        list.addAll(data);
        refreshController.refreshCompleted();
        // 小于分页的数量,禁止上拉加载更多
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          //防止上次上拉加载更多失败,需要重置状态
          refreshController.loadComplete();
        }
      }
    }
    else if(code == -1){
      if (_refreshController.init) list.clear();
      refreshController.refreshFailed();
    }
    else{
      refreshController.refreshCompleted(resetFooterState: true);
    }
    return code;
  }

  /// 上拉加载更多
  Future loadMore() async {
    data = null;
    var code = await loadData(pageNum: ++_currentPageNum);
    if(code == 1) {
      if (data.isEmpty) {
        _currentPageNum--;
        refreshController.loadNoData();
      } else {
        list.addAll(data);
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      }
    }
    else if(code == -1){
      _currentPageNum--;
      refreshController.loadFailed();
    }
    else{
      _currentPageNum--;
      refreshController.loadFailed();
    }
    return code;
  }

  // 加载数据
  Future loadData({int pageNum});

  // @override
  // void dispose() {
  //   _refreshController?.dispose();
  //   super.dispose();
  // }

}