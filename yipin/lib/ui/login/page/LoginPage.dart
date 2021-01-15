
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_refresh_indicator/lazy_load_refresh_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yipin/base/adapter/BaseAdapter.dart';
import 'package:yipin/base/widget/TextView.dart';
import 'package:yipin/base/widget/ptr/PtrWidget.dart';
import 'package:yipin/ui/login/viewmodel/LoginVM.dart';
import '../../../base/view/BasePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage,LoginVM> {

  @override
  LoginVM getViewModel() =>  LoginVM();


  List<String> items = List.generate(4, (index) => index.toString()).toList();
  PtrController _refreshController = PtrController();

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    if(items.length == 30){
      _refreshController.loadComplete();
      return;
    }
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  @override
  Widget getView(BuildContext context) {
    return PtrWidget(
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      adapter: BaseAdapter<String>(
          data: items,
          builder: (context,index,model){
            return Card(child: Center(child: Text(model)));
          }
      ),

    );
  }
}

