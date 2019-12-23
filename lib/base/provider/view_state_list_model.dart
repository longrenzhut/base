
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'view_state_model.dart';

abstract class ViewStateListModel<T> extends ViewStateModel{

  static const int pageNumFirst = 1;

  static const int pageSize = 10;

  RefreshController _refreshController;

  RefreshController get refreshController => _refreshController;

  /// 当前页码
  int _currentPageNum = pageNumFirst;

  /// 页面数据
  List<T> list = [];


  @override
  initData(){
    if(null == _refreshController)
      _refreshController = RefreshController(initialRefresh: false);
    setBusy();
    refresh();
  }


  void refresh() async{
    _currentPageNum = pageNumFirst;
    loadData(pageNum: _currentPageNum);
  }

  void loadMore() async{
    loadData(pageNum: _currentPageNum);
  }


  void refreshCompleted(List<T> data) {
    if (data.isEmpty) {
      refreshController.refreshCompleted(resetFooterState: true);
      list.clear();
      setEmpty();
    }
    else{
      isInit = false;
      list.clear();
      list.addAll(data);
      refreshController.refreshCompleted();
      // 小于分页的数量,禁止上拉加载更多
      if (data.length < pageSize) {
        refreshController.loadNoData();
      } else {
        //防止上次上拉加载更多失败,需要重置状态
        refreshController.loadComplete();
      }
      setIdle();
    }
    _currentPageNum ++;
  }


  void loadFailed(){
    if (_currentPageNum == 1){
      if(null != refreshController)
        refreshController.refreshFailed();

      setError();
    }
    else{
      refreshController.loadFailed();
    }
  }

  void loadMoreCompleted(List<T> data){
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
      notifyListeners();
    }
  }


  // 加载数据
  void loadData({int pageNum});


  @override
  void dispose() {
    if(null != _refreshController)
      _refreshController.dispose();
    super.dispose();
  }
}