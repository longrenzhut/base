class ItemModel {


  String _title;
  String _content;
  int _icon;
  String _url;
  int _isSelected;
  int _type;

  String get title => _title;

  set title(String value) {
    _title = value;
  }


  int get type => _type;

  set type(int value) {
    _type = value;
  }

  String get content => _content;

  int get isSelected => _isSelected;

  set isSelected(int value) {
    _isSelected = value;
  }

  set content(String value) {
    _content = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  int get icon => _icon;

  set icon(int value) {
    _icon = value;
  }


}
