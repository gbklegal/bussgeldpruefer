import 'package:flutter/material.dart';

void newScreen({context, newScreen}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => newScreen,
    ),
  );
}
