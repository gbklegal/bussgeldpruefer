import 'package:app/screens/auth/login.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 200.0,
            child: ElevatedButton(
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                primary: Color(0xff5CC8C5),
                onPrimary: Colors.white,
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
              },
            ),
          )
        ],
      ),
    );
  }
}
