import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Calculator(),
    debugShowCheckedModeBanner: false,
  ));
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _current = "0";
  double num1 = 0;
  String operand = "";

  void _btnPressed(String text) {
    setState(() {
      if (text == "C") {
        _output = "0";
        _current = "0";
        num1 = 0;
        operand = "";
      } else if (text == "+" || text == "-" || text == "x" || text == "/") {
        num1 = double.parse(_output);
        operand = text;
        _current = "0";
      } else if (text == "=") {
        double num2 = double.parse(_output);
        if (operand == "+") _output = (num1 + num2).toString();
        if (operand == "-") _output = (num1 - num2).toString();
        if (operand == "x") _output = (num1 * num2).toString();
        if (operand == "/") _output = (num1 / num2).toString();
        operand = "";
      } else {
        if (_current == "0") _current = text; else _current += text;
        _output = _current;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(child: Container(alignment: Alignment.bottomRight, padding: const EdgeInsets.all(24), child: Text(_output, style: const TextStyle(color: Colors.white, fontSize: 60)))),
          Column(children: [
            ["7", "8", "9", "/"], ["4", "5", "6", "x"], ["1", "2", "3", "-"], ["C", "0", "=", "+"]
          ].map((row) => Row(children: row.map((btn) => Expanded(child: TextButton(onPressed: () => _btnPressed(btn), child: Text(btn, style: const TextStyle(fontSize: 24, color: Colors.orange))))).toList())).toList())
        ],
      ),
    );
  }
}
