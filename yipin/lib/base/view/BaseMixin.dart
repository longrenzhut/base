
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin BaseMixin {


  Widget getView(BuildContext context);

  Widget getAppBar(BuildContext context){
    return null;
  }


  Map  argumentOf(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    return map;
  }

    T providerOf<T>(BuildContext context){
    return Provider.of<T>(context,listen: false);
  }




}
