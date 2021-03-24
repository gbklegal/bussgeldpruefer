import 'package:flutter/material.dart';

import '../screens/webview.dart';

class WebViewWidget extends StatelessWidget {
  final String url;
  final bool allowJavascript;

  WebViewWidget({this.url, this.allowJavascript: false});

  @override
  Widget build(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(
          url: 'https://xn--bussgeldprfer-5ob.com/impressum/?app_mode',
        ),
      ),
    );
  }
}
