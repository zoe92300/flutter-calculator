import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zoe\'s Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == '=') {
        try {
          final expression = Expression.parse(_expression);
          const evaluator = ExpressionEvaluator();
          final eval = evaluator.eval(expression, {});
          _result = eval.toString();
          _expression = '$_expression = $_result';
        } catch (e) {
          _result = 'Error';
        }
      } else if (value == 'C') {
        _expression = '';
        _result = '';
      } else {
        if (_expression.endsWith('=') && value != 'C') {
          _expression = _result + value;
          _result = '';
        } else {
          _expression += value;
        }
      }
    });
  }

 Widget _buildButton(String value) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[100], 
          foregroundColor: Colors.blue[600],  
          padding: const EdgeInsets.all(20), 
          shape: const CircleBorder(),
        ),
        onPressed: () => _onButtonPressed(value),
        child: Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: AppBar(
      title: Text('Zoe\'s Calculator',
        style: TextStyle(
          fontSize: 35, 
          fontWeight: FontWeight.bold, 
          color: Colors.grey[700]
          ),
      ),
    centerTitle: true,
  ),
),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue[50],
              alignment: Alignment.bottomRight,
              child: Text(
                _expression,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 32,),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Row(
                  children: ['7', '8', '9', '/'].map(_buildButton).toList(),
                ),
                Row(
                  children: ['4', '5', '6', '*'].map(_buildButton).toList(),
                ),
                Row(
                  children: ['1', '2', '3', '-'].map(_buildButton).toList(),
                ),
                Row(
                  children: ['0', '.', 'C', '+'].map(_buildButton).toList(),
                ),
                Row(
                  children: ['='].map(_buildButton).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
