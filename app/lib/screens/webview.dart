import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
  final bool allowJavascript;

  WebViewScreen({this.url, this.allowJavascript: false});

  _allowJavascript() {
    if (allowJavascript) return JavascriptMode.unrestricted;
    return JavascriptMode.disabled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: WebView(
          initialUrl: url,
          javascriptMode: _allowJavascript(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.close),
        tooltip: 'schließen',
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewScreen extends StatelessWidget {
//   final String url;
//   final bool allowJavascript;

//   WebViewScreen({this.url, this.allowJavascript: false});

//   _allowJavascript() {
//     if (allowJavascript) return JavascriptMode.unrestricted;
//     return JavascriptMode.disabled;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: MediaQuery.of(context).padding,
//         child: WebView(
//           initialUrl: url,
//           javascriptMode: _allowJavascript(),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.pop(context),
//         child: Icon(Icons.close),
//         tooltip: 'schließen',
//       ),
//     );
//   }
// }
