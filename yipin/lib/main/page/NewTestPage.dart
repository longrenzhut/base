

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/base/page/BasePage.dart';
import 'package:base/extension/ListExt.dart';
import 'package:base/extension/WidgetExt.dart';
import 'package:yipin/main/viewmodel/NewTestVM.dart';
import 'package:yipin/main/widget/Paper.dart';

class NewTest extends StatefulWidget {
  @override
  _NewTestState createState() => _NewTestState();
}

class _NewTestState extends BasePageState<NewTest,NewTestVM> {

  @override
  NewTestVM getViewModel() =>  NewTestVM();

  @override
  Widget getView(BuildContext context) {
    return Paper();
  }
}
