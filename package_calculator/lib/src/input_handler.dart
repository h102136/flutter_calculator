import 'dart:io';

class InputHandler {
  // Method to get the expression from the user
  String getExpression() {
    while (true) {
      // use stdout.write() instead of print() to keep the cursor on the same line
      stdout.write("Enter an expression ex:(7+8.5)*5-9/3 (+, -, *, / only) or Q for quit: ");
      // use stdin.readLineSync() to read the input from the user
      String? expression = stdin.readLineSync();

      // Check if the user wants to quit
      if (expression != null && expression.toUpperCase() == "Q") {
        exit(0);
      }
      if (expression != null && validateExpression(expression)) {
        return expression;
      }
    }
  }

  // Check if the expression is valid with limited operators
  bool validateExpression(String expression) {
    // Define the valid characters (0-9, ., +, -, *, /, (, ))
    RegExp validChars = RegExp(r'^[\d\.\+\-\*\/\(\)]+$');
    // Define the pattern for consecutive operators
    RegExp consecutiveOperators = RegExp(r'[\+\-\*\/]{2,}');
    // Define the pattern for trailing operators
    RegExp trailingOperator = RegExp(r'[\+\-\*\/]$');

    // If the expression contains invalid characters, will ask the user to re-enter the expression
    if (!validChars.hasMatch(expression)) {
      print("The expression contains invalid characters");
      return false;
    }

    // If the expression contains consecutive operators, return False
    if (consecutiveOperators.hasMatch(expression)) {
      print("The expression contains consecutive operators");
      return false;
    }

    // If the expression ends with an operator, return False
    if (trailingOperator.hasMatch(expression)) {
      print("The expression ends with an operator");
      return false;
    }

    // Check for balanced parentheses
    int openParentheses = 0;
    for (int i = 0; i < expression.length; i++) {
      if (expression[i] == '(') {
        openParentheses++;
      } else if (expression[i] == ')') {
        openParentheses--;
      }
      // If at any point closing parentheses are more than opening, it's invalid
      if (openParentheses < 0) {
        print("The expression has unmatched parentheses");
        return false;
      }
    }
    // If there are unmatched opening parentheses, return False
    if (openParentheses != 0) {
      print("The expression has unmatched parentheses");
      return false;
    }

    return true;
  }
}
