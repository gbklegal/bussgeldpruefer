import 'package:app/constants.dart';
import 'package:app/functions/newscreen.dart';
import 'package:app/screens/authenticate/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BigButtonWidget extends StatelessWidget {
  final String title;
  final String text;
  final String image;
  final Widget screen;
  final int index;
  final int flag;

  BigButtonWidget({
    this.title,
    this.text,
    this.image: '',
    this.screen,
    this.index,
    this.flag,
  });

  initState() {
    print(this.image);
  }

  _image() {
    if (this.image != '') {
      return Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: Image.asset(
          this.image,
          width: 60.0,
        ),
      );
    }
    return Container();
  }

  _nextScreen([context]) {
    if (this.screen == null) {
      print('BigButtonWidget() pressed');
    } else {
      newScreen(
        context: context,
        screen: this.screen,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: flag == 1 ? kSecondaryColor : kPrimaryColor),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.left,
                    softWrap: true,
                  ),
                ],
              ),
            ),
            _image(),
          ],
        ),
      ),
      onPressed: () {
        if (index == 1) {
          if (FirebaseAuth.instance.currentUser == null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()));
          } else
            _nextScreen(context);
        } else
          _nextScreen(context);
      },
      onLongPress: () => print('BigButtonWidget() long press'),
    );
  }
}
