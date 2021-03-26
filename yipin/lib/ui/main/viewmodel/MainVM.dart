import 'package:yipin/base/base/viewmodel/BaseViewModel.dart';

import '../../../base/widget/MyIndexStack.dart';


class MainVM extends BaseViewModel{

  var indexStackController = IndexStackController();

  @override
  void dispose() {
    indexStackController?.dispose();
    super.dispose();
  }
}
