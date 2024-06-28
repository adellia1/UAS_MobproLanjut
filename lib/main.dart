import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _expression = '';
  String _result = '';
  List<String> _history = [];

  void _onButtonPress(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '';
        _result = '';
      } else if (buttonText == '←') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (buttonText == '=') {
        try {
          _result = _calculate(_expression);
          _history.insert(0, '$_expression = $_result');
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += buttonText;
      }
    });
  }

  String _calculate(String expression) {
    try {
      expression = expression.replaceAll('x', '*').replaceAll('%', '/100');
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black87,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('History'),
                  value: 'History',
                ),
                PopupMenuItem(
                  child: Text('About'),
                  value: 'About',
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'History') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return HistoryDialog(history: _history);
                  },
                );
              } else if (value == 'About') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AboutDialog();
                  },
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _expression,
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _result,
                        style:
                            TextStyle(fontSize: 32, color: Colors.greenAccent),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 1,
                padding: EdgeInsets.all(8.0),
                shrinkWrap: true,
                children: [
                  CalculatorButton('C',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 38, 38, 207),
                      textColor: Colors.white),
                  CalculatorButton('%',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 38, 38, 207),
                      textColor: Colors.white),
                  CalculatorButton('←',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 38, 38, 207),
                      textColor: Colors.white),
                  CalculatorButton('/',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 38, 38, 207),
                      textColor: Colors.white),
                  CalculatorButton('7',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 255, 255, 255),
                      textColor: Colors.black),
                  CalculatorButton('8',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 255, 255, 255),
                      textColor: Colors.black),
                  CalculatorButton('9',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 255, 255, 255),
                      textColor: Colors.black),
                  CalculatorButton('x',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 38, 38, 207),
                      textColor: Colors.white),
                  CalculatorButton('4',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 255, 255, 255),
                      textColor: Colors.black),
                  CalculatorButton('5',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 255, 255, 255),
                      textColor: Colors.black),
                  CalculatorButton('6',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 255, 255, 255),
                      textColor: Colors.black),
                  CalculatorButton('-',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 38, 38, 207),
                      textColor: Colors.white),
                  CalculatorButton('1',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 255, 255, 255),
                      textColor: Colors.black),
                  CalculatorButton('2',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 255, 255, 255),
                      textColor: Colors.black),
                  CalculatorButton('3',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 255, 255, 255),
                      textColor: Colors.black),
                  CalculatorButton('+',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 38, 38, 207),
                      textColor: Colors.white),
                  CalculatorButton('0',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 255, 255, 255),
                      textColor: Colors.black),
                  CalculatorButton('00',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 255, 255, 255),
                      textColor: Colors.black),
                  CalculatorButton('.',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 255, 255, 255),
                      textColor: Colors.black),
                  CalculatorButton('=',
                      onPressed: _onButtonPress,
                      color: Color.fromARGB(255, 38, 38, 207),
                      textColor: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final void Function(String) onPressed;
  final Color? color;
  final Color? textColor;

  CalculatorButton(this.text,
      {required this.onPressed, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () => onPressed(text),
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: textColor ?? Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.blueGrey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}

class HistoryDialog extends StatelessWidget {
  final List<String> history;

  HistoryDialog({required this.history});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('History'),
      content: Container(
        width: double.maxFinite,
        height: 300,
        child: ListView.builder(
          itemCount: history.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(history[index]),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

class AboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tentang Aplikasi'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Aplikasi ini adalah kalkulator sederhana.',
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 8),
          Text(
            'Dikembangkan sebagai proyek Ujian Akhir Semester (UAS) dalam matakuliah Mobile Programming Lanjut di STMIK Widya Utama Purwokerto.',
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 8),
          Text(
            'Dikembangkan oleh:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Agus Prianti STI202102397',
          ),
          Text(
            'Adelia Oktaviani SI202102187',
          ),
          Text(
            'Shafira Indes Prafitri STI202102125',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
