import 'package:flutter/material.dart';

void newScreen({context, screen}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}
