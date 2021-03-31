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
    return IconButton(
      icon: Icon(
        Icons.arrow_back_outlined,
        color: Colors.black,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  _actionsContent(context) {
    if (hideInfoButton) {
      return <Widget>[];
    }
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.help_outline,
          color: Colors.black,
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
      backgroundColor: Colors.white,
      leading: _leadingContent(context),
      title: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onDoubleTap: () => newScreen(
            context: context,
            screen: HiddenDevScreen(),
          ),
          child: Image.asset(
            'assets/logo/BussgeldPruefer-Logo-small.png',
            height: 30,
            fit: BoxFit.cover,
          ),
        ),
      ),
      actions: _actionsContent(context),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
