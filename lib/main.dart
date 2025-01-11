import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = ''; //'0'
  String _input = '';
  double _firstOperand = 0;
  double _secondOperand = 0;
  String _operator = '';

  // Update display when a button is pressed
  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _input = '';
        _output = ''; //'0'
        _firstOperand = 0;
        _secondOperand = 0;
        _operator = '';
      } else if (buttonText == '=') {
        _secondOperand = double.tryParse(_input) ?? 0;
        if (_operator == '+') {
          _output = (_firstOperand + _secondOperand).toString();
        } else if (_operator == '-') {
          _output = (_firstOperand - _secondOperand).toString();
        } else if (_operator == '*') {
          _output = (_firstOperand * _secondOperand).toString();
        } else if (_operator == '/') {
          if (_secondOperand != 0) {
            _output = (_firstOperand / _secondOperand).toString();
          } else {
            _output = 'Error';
          }
        }
        _input = _output;
        _firstOperand = 0;
        _secondOperand = 0;
        _operator = '';
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '*' ||
          buttonText == '/') {
        _firstOperand = double.tryParse(_input) ?? 0;
        _operator = buttonText;
        _input = '';
        _output += buttonText;
      } else {
        _input += buttonText;
        _output += _input;
      }
    });
  }

  // Build button widgets
  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () => _buttonPressed(buttonText),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 24),
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _output,
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('C'),
              _buildButton('0'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }
}
