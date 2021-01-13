
import 'package:flutter/widgets.dart';
import 'package:universal_html/html.dart';
import 'package:webview_flutter/webview_flutter.dart' as web_view;


class MyWebWidget extends StatefulWidget {

  final String initialUrl;
  final bool javascript;
  final Function(String url) onPageStarted;
  final Function(String url) onPageFinished;

  MyWebWidget({@required this.initialUrl, @required this.javascript,
  this.onPageStarted,
  this.onPageFinished,
  })
      : assert(initialUrl != null),
        assert(javascript != null);

  @override
  _MyWebWidgetState createState() => _MyWebWidgetState();
}

class _MyWebWidgetState extends State<MyWebWidget> {
  Widget _builtWidget;

  @override
  Widget build(BuildContext context) {
    _builtWidget ??= web_view.WebView(
      onPageStarted: widget.onPageStarted,
      onPageFinished: widget.onPageFinished,
      initialUrl: widget.initialUrl,
      javascriptMode: widget.javascript
          ? web_view.JavascriptMode.unrestricted
          : web_view.JavascriptMode.disabled,
    );
    return _builtWidget;
  }

  @override
  void didUpdateWidget(MyWebWidget oldWidget) {
    if (!(widget.initialUrl == oldWidget.initialUrl)) {
      _builtWidget = null;
    }
    super.didUpdateWidget(oldWidget);
  }
}
