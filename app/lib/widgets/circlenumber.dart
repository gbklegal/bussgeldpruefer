import 'package:flutter/material.dart';

class CircleNumber extends StatelessWidget {
  final double containerSize = 40.0;
  final String number;

  CircleNumber(this.number);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(containerSize)),
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
