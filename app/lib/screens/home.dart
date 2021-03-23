import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final String name;

  Home(this.name);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome $name',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
