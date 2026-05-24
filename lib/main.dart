import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String dynamicText = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";
  String _output = "0";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      num1 = double.parse(dynamicText);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) return;
      _output = _output + buttonText;
    } else if (buttonText == "=") {
      num2 = double.parse(dynamicText);
      if (operand == "+") _output = (num1 + num2).toString();
      if (operand == "-") _output = (num1 - num2).toString();
      if (operand == "×") _output = (num1 * num2).toString();
      if (operand == "÷") _output = (num1 / num2).toString();
      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    setState(() {
      dynamicText = double.parse(_output).toStringAsFixed(0);
      if (_output.contains(".")) dynamicText = double.parse(_output).toString();
    });
  }

  Widget buildButton(String buttonText, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(24),
            backgroundColor: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: Text(buttonText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("آلة حاسبة ذكية"), backgroundColor: Colors.blueGrey[900]),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 48, horizontal: 12),
            child: Text(dynamicText, style: TextStyle(fontSize: 60, color: Colors.white)),
          ),
          Expanded(child: Divider()),
          Column(children: [
            Row(children: [buildButton("7", Colors.grey[850]!), buildButton("8", Colors.grey[850]!), buildButton("9", Colors.grey[850]!), buildButton("÷", Colors.orange)]),
            Row(children: [buildButton("4", Colors.grey[850]!), buildButton("5", Colors.grey[850]!), buildButton("6", Colors.grey[850]!), buildButton("×", Colors.orange)]),
            Row(children: [buildButton("1", Colors.grey[850]!), buildButton("2", Colors.grey[850]!), buildButton("3", Colors.grey[850]!), buildButton("-", Colors.orange)]),
            Row(children: [buildButton(".", Colors.grey[850]!), buildButton("0", Colors.grey[850]!), buildButton("C", Colors.redAccent), buildButton("+", Colors.orange)]),
            Row(children: [buildButton("=", Colors.green)]),
          ])
        ],
      ),
    );
  }
}
