import 'package:flutter/material.dart';

class ContactFeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              color: Colors.blue,
              fontSize: 22,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Deine Anfrage ist eingegangen.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    '\n\nWir werden uns in spätestens 48 Stunden bei Dir melden.',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.close),
      ),
    );
  }
}
