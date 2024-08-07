// test/calculator_page_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_calculator/main.dart'; 

void main() {
  testWidgets('CalculatorPage has a TextField, ElevatedButton, and displays result', (WidgetTester tester) async {
    // create CalculatorPage and trigger a frame
    await tester.pumpWidget(MaterialApp(home: CalculatorPage()));

    // create Finders
    final textFieldFinder = find.byType(TextField); // Find a TextField widget
    final calculateButtonFinder = find.byKey(Key('button_calculate')); // Find the calculate button by Key
    final resultFinder = find.textContaining('Result:'); // Find a Text widget containing 'Result:'

    // use the Finders to verify the presence of the widgets
    expect(textFieldFinder, findsOneWidget);
    expect(calculateButtonFinder, findsOneWidget);
    expect(resultFinder, findsOneWidget);

    // enter a valid expression and tap the button
    await tester.enterText(textFieldFinder, '(7*8)+4/2-7');
    await tester.tap(calculateButtonFinder);
    await tester.pump(); // trigger a rebuild

    // verify that the result is displayed
    expect(find.text('Result: 51.0'), findsOneWidget);
  });

  testWidgets('CalculatorPage displays "Invalid expression" for invalid input', (WidgetTester tester) async {
    // create CalculatorPage and trigger a frame
    await tester.pumpWidget(MaterialApp(home: CalculatorPage()));

    // create Finders
    final textFieldFinder = find.byType(TextField); // Find a TextField widget
    final calculateButtonFinder = find.byKey(Key('button_calculate')); // Find the calculate button by Key

    // enter an invalid expression and tap the button
    await tester.enterText(textFieldFinder, '**++');
    await tester.tap(calculateButtonFinder);
    await tester.pump(); // trigger a rebuild

    // verify that the result is displayed 'Invalid expression'
    expect(find.text('Result: Invalid expression'), findsOneWidget);
  });
}