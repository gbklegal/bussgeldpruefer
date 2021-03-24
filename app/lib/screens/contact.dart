import 'package:flutter/material.dart';

import '../widgets/appbar.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        isHome: false,
      ),
      body: Center(
        child: Text('Kontaktformular... coming soon'),
      ),
    );
  }
}
