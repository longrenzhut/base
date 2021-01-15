import '../base/provider/ListViewModel.dart';

class TestVM extends ListViewModel<String>{
  @override
  Future loadData({int pageNum}) async{
    await Future.delayed(Duration(milliseconds: 1000));
    data =  List.generate(list.length > 40 ? 5: 10, (index) => index.toString()).toList();
    return 1;
  }
}
