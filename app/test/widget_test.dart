import 'package:app/widgets/circlenumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('render a number in a circle', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CircleNumber('1'),
      ),
    );

    expect(find.text('1'), findsOneWidget);
  });
}
