import '../../../base/widget/MyIndexStack.dart';

import '../../../base/provider/BaseViewModel.dart';

class MainVM extends BaseViewModel{

  var indexStackController = IndexStackController();

  @override
  void dispose() {
    indexStackController?.dispose();
    super.dispose();
  }
}
