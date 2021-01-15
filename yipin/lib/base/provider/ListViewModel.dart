
import 'package:yipin/base/widget/ptr/PtrWidget.dart';

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
    try {
      _currentPageNum = pageNumFirst;
      data = null;
      var code = await loadData(pageNum: pageNumFirst);

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
      return code;
    } catch (e, s) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      if (_refreshController.init) list.clear();
      refreshController.refreshFailed();

      return -1;
    }
  }

  /// 上拉加载更多
  Future loadMore() async {
    try {
      data = null;
      await loadData(pageNum: ++_currentPageNum);
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
    } catch (e, s) {
      _currentPageNum--;
      refreshController.loadFailed();
      notifyListeners();
    }
  }

  // 加载数据
  Future loadData({int pageNum});

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

}