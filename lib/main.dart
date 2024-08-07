import 'package:flutter/material.dart';
import 'package:package_calculator/package_calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // manage the input of users text form field
  final _inputController = TextEditingController();
  // store the result of the calculation
  String _result = '';
  // create an instance of 'input_handler'
  final _inputHandler = InputHandler();
  // create an instance of 'calculator'
  final _calculator = Calculator();

  void _calculate() {
    // get the expression from the input field
    String expression = _inputController.text;
    // call 'validateExpression' method to check if the expression is valid
    if (_inputHandler.validateExpression(expression)) {
      setState(() {
        // call the evaluateExpression method to calculate the result
        double result = _calculator.evaluateExpression(expression);
        // store the result in '_result' variable
        _result = result.toString();
      });
    } else {
      setState(() {
        // if the expression is invalid, set the result to 'Invalid expression'
        _result = 'Invalid expression';
      });
    }
  }

  void _clear() {
    setState(() {
      _inputController.clear();
      _result = '';
    });
  }

  void _onKeyPressed(String key) {
    setState(() {
      _inputController.text += key;
    });
  }

  @override
  // build the UI
  Widget build(BuildContext context) {
    // return a scaffold widget as the root of the widget tree
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
      ),
      // the body of the scaffold
      body: Padding(
        // add padding as 16.0 pixels
        padding: const EdgeInsets.all(16.0),
        // a column widget to display the children widgets in a vertical order
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // a text form field to get the input from the user
            TextField(
              controller: _inputController,
              // a label for the text form field
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter an expression',
              ),
              keyboardType: TextInputType.text,
            ),
            // add a sized box with height 16.0 pixels
            SizedBox(height: 16.0),
            // a button widget to calculate the result
            ElevatedButton(
              key: Key('button_calculate'),
              onPressed: _calculate,
              child: Text('Calculate'),
            ),
            SizedBox(height: 16.0),
            // a button widget to clear the input and result
            ElevatedButton(
              key: Key('button_clear'),
              onPressed: _clear,
              child: Text('Clear'),
            ),
            SizedBox(height: 16.0),
            // a text widget to display the result
            Text(
              'Result: $_result',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            // a grid view to display the calculator keys
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  _buildKey('7'),
                  _buildKey('8'),
                  _buildKey('9'),
                  _buildKey('/'),
                  _buildKey('4'),
                  _buildKey('5'),
                  _buildKey('6'),
                  _buildKey('*'),
                  _buildKey('1'),
                  _buildKey('2'),
                  _buildKey('3'),
                  _buildKey('-'),
                  _buildKey('0'),
                  _buildKey('('),
                  _buildKey(')'),
                  _buildKey('+'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKey(String key) {
    return ElevatedButton(
      key: Key('button_$key'),
      onPressed: () => _onKeyPressed(key),
      child: Text(key, style: TextStyle(fontSize: 24.0)),
    );
  }
}