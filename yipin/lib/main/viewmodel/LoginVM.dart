

import 'package:base/base/viewmodel/ListViewModel.dart';

class LoginVM extends ListViewModel<String>{

  Future loadData() {
     Future.delayed(Duration(milliseconds: 1000));
    data =  List.generate(list.length > 40 ? 5: 10, (index) => index.toString()).toList();

    return Future.value(1);
  }


}
