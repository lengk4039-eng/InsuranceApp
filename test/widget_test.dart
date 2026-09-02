// Basic smoke test: the app should boot straight into the splash screen.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:insuranceapp/main.dart';

void main() {
  testWidgets('App boots into the splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Insurance App'), findsOneWidget);
    expect(find.byIcon(Icons.shield), findsOneWidget);
  });
}
