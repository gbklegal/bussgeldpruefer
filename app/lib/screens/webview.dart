import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  final bool allowJavascript;

  WebViewScreen({
    this.url,
    this.title: '',
    this.allowJavascript: false,
  });

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool isLoading = true;
  int _loadingProgressValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(widget.title),
        actions: [
          NavigationControls(_controller.future),
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: SafeArea(
              child: WebView(
                initialUrl: widget.url,
                javascriptMode: (widget.allowJavascript)
                    ? JavascriptMode.unrestricted
                    : JavascriptMode.disabled,
                onWebViewCreated: (WebViewController controller) {
                  _controller.complete(controller);
                },
                onProgress: (int progress) {
                  setState(() => _loadingProgressValue = progress);
                },
                navigationDelegate: (NavigationRequest request) {
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  setState(() => isLoading = true);
                },
                onPageFinished: (String url) {
                  setState(() => isLoading = false);
                },
                // gestureNavigationEnabled: true,
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
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      });
                },
              ),
            ),
          ),
          isLoading
              ? SafeArea(
                  child: LinearProgressIndicator(
                    value: _loadingProgressValue.toDouble() / 100,
                  ),
                )
              : Stack(),
          // isLoading ? Center(child: CircularProgressIndicator()) : Stack(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;

        return Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoBack()) {
                        await controller.goBack();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Sie können nicht zurück gehen'),
                          ),
                        );
                      }
                    },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoForward()) {
                        await controller.goForward();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Sie können nicht vorwärts gehen'),
                          ),
                        );
                      }
                    },
            ),
            IconButton(
              icon: Icon(Icons.replay),
              onPressed: !webViewReady ? null : () => controller.reload(),
            ),
          ],
        );
      },
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
