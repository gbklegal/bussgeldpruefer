import 'package:flutter/material.dart';

import '../functions/webview.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen(this.name);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Welcome $name',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.0),
          ElevatedButton(
            onPressed: () => webView(
              url: 'https://xn--bussgeldprfer-5ob.com/impressum/?app_mode',
              context: context,
            ),
            child: Text('Impressum'),
          ),
        ],
      ),
    );
  }
}
