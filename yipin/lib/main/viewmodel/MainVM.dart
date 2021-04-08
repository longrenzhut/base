
import 'package:base/base/viewmodel/BaseViewModel.dart';
import 'package:base/widget/MyIndexStack.dart';



class MainVM extends BaseViewModel{

  var indexStackController = IndexStackController();

  @override
  void dispose() {
    indexStackController?.dispose();
    super.dispose();
  }
}
