import 'package:app/constants.dart';
import 'package:app/functions/newscreen.dart';
import 'package:app/screens/hiddendev.dart';
import 'package:app/screens/information.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final bool isHome;
  final bool hideInfoButton;

  AppBarWidget({
    this.isHome = false,
    this.hideInfoButton = false,
  });

  _leadingContent(context) {
    if (isHome) {
      return Text('');
    }
    return BackButton(color: Colors.black);
  }

  _actionsContent(context) {
    if (hideInfoButton) {
      return <Widget>[];
    }
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.help_outline,
          color: kSecondaryColor,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InformationScreen()),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: _leadingContent(context),
      title: GestureDetector(
        onDoubleTap: () => newScreen(
          context: context,
          screen: HiddenDevScreen(),
        ),
        child: Image.asset(
          'assets/images/Logo-BussgeldPruefer-small.png',
          height: 30,
          fit: BoxFit.cover,
        ),
      ),
      actions: _actionsContent(context),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
