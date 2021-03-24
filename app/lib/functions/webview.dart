import 'package:flutter/material.dart';

import '../screens/webview.dart';

webView({context, final String url, final bool allowJavascript: false}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => WebViewScreen(
        url: url,
        allowJavascript: false,
      ),
    ),
  );
}
