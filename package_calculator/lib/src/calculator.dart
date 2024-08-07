class Calculator {
  // Evaluate the expression
  double evaluateExpression(String expression) {
    // Parse the expression
    return parseExpression(expression);
  }

  double parseExpression(String expression) {
    List<String> operators = [];
    List<double> values = [];
    int i = 0; // Index of the expression

    // Function to get precedence of operators
    int precedence(String operator) {
      if (operator == '+' || operator == '-') {
        return 1;
      } else if (operator == '*' || operator == '/') {
        return 2;
      }
      return 0;
    }

    while (i < expression.length) {
      // If the character is a digit or a dot, parse the number
      if (RegExp(r'\d').hasMatch(expression[i]) || expression[i] == '.') {
        String number = '';
        while (i < expression.length && (RegExp(r'\d').hasMatch(expression[i]) || expression[i] == '.')) {
          number += expression[i];
          i++;
        }
        values.add(double.parse(number));
        i--; // Decrement the index by 1 to avoid skipping the next character after the number
      } else if ('+-*/'.contains(expression[i])) {
        while (operators.isNotEmpty && precedence(operators.last) >= precedence(expression[i])) {
          applyOperator(operators, values);
        }
        operators.add(expression[i]);
      } else if (expression[i] == '(') {
        operators.add(expression[i]);
      } else if (expression[i] == ')') {
        while (operators.last != '(') {
          applyOperator(operators, values);
        }
        operators.removeLast();
      }
      i++;
    }

    while (operators.isNotEmpty) {
      applyOperator(operators, values);
    }

    return values[0];
  }

  void applyOperator(List<String> operators, List<double> values) {
    String operator = operators.removeLast(); // Get the last operator in "operators" list
    double right = values.removeLast(); // Get the last value in "values" list as "right"
    double left = values.removeLast(); // Get the last value in "values" list as "left" after removing the last value as "right"

    // Apply the operator to "left" and "right" and append the result to "values" list
    if (operator == '+') {
      values.add(left + right);
    } else if (operator == '-') {
      values.add(left - right);
    } else if (operator == '*') {
      values.add(left * right);
    } else if (operator == '/') {
      values.add(left / right);
    }
  }
}
