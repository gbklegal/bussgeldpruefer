import 'package:flutter/material.dart';

import '../screens/webview.dart';

webView({
  context,
  final String url,
  final String title,
  final bool allowJavascript: false,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => WebViewScreen(
        url: url,
        title: title,
        allowJavascript: false,
      ),
    ),
  );
}
