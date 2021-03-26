import 'package:flutter/material.dart';

import 'package:app/functions/newscreen.dart';

import 'package:app/widgets/appbar.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Profile'),
          ElevatedButton(
            child: Text('Login'),
            onPressed: () => newScreen(
              context: context,
              screen: LoginScreen(),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        isHome: false,
      ),
      body: Center(
        child: ElevatedButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.close),
              Text('Close LoginScreen'),
            ],
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
