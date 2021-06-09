import 'package:flutter/material.dart';
import 'package:app/constants.dart';

import 'components/body.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        title: Text(
      "Kristin Watson",
      style: TextStyle(fontSize: 16),
    ));
  }
}
