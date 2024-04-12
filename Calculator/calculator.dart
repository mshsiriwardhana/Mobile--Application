library flutter_ios_calculator;

import 'package:flutter/material.dart';
import 'style_12.dart' as Calculator12;

class Calculator extends StatelessWidget {
  final CalculatorType? calculatorType;

  const Calculator({Key? key, this.calculatorType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Calculator12.Calculator();
  }
}

enum CalculatorType { ios10, ios12 }
