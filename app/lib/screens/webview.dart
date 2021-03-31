import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final bool allowJavascript;

  WebViewScreen({
    this.url,
    this.allowJavascript: false,
  });

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;

  _allowJavascript() {
    if (widget.allowJavascript) return JavascriptMode.unrestricted;
    return JavascriptMode.disabled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: MediaQuery.of(context).padding,
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: _allowJavascript(),
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
              onWebResourceError: (WebResourceError error) {
                String _url = widget.url;
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Fehler'),
                        content: Text(
                            'Die URL $_url konnte nicht aufgerufen werden.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator()) : Stack(),
        ],
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
