import 'package:app/screens/quickcheck.dart';
import 'package:app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class QuickCheckHome extends StatefulWidget {
  const QuickCheckHome({key}) : super(key: key);

  @override
  _QuickCheckHomeState createState() => _QuickCheckHomeState();
}

class _QuickCheckHomeState extends State<QuickCheckHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: QuickCheckScreen(),
    );
  }
}
