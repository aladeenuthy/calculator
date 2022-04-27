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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String num1 = '0';
  String num2 = '0';
  String? prevOperand;
  String? operand;
  String prevInput = '';
  double result = 0;
  var _finalResult = "0";
  void _process(String input) {
    if (input == '+' || input == '-' || input == '/' || input == 'X') {
      operand = input;
      if (num2 != "0" && prevInput != "=") {
        if (prevOperand == '+') {
          result = double.parse(num1) + double.parse(num2);
        } else if (prevOperand == "-") {
          result = double.parse(num1) - double.parse(num2);
        } else if (prevOperand == "X") {
          result = double.parse(num1) * double.parse(num2);
        } else if (prevOperand == '/') {
          result = double.parse(num1) / double.parse(num2);
        }
        num1 = result.toStringAsFixed(2);
        num2 = '0';
        
        setState(() {
          _finalResult = result.toString();
        });
      }
      prevOperand = input;
      prevInput = '';
      num2 = '0';
    } else if (input == "C") {
      num1 = '0';
      num2 = '0';
      operand = null;
      result = 0;
      prevInput = '';
      prevOperand = null;
      setState(() {
        _finalResult = "0";
      });
    } else if (input == "=") {
      if (operand != null) {
        if (operand == '+') {
          result = double.parse(num1) + double.parse(num2);
        } else if (operand == "-") {
          result = double.parse(num1) - double.parse(num2);
        } else if (operand == "X") {
          result = double.parse(num1) * double.parse(num2);
        } else if (operand == '/') {
          result = double.parse(num1) / double.parse(num2);
        }
        num1 = result.toString();
        prevInput = '=';
        setState(() {
          _finalResult = result.toStringAsFixed(2);
        });
      } else {
        return;
      }
    } else if (input == '.'){
      if (operand == null) {
        if(!num1.contains('.')) num1 += input;
        prevInput = '';
        setState(() {
          _finalResult = num1.substring(1);
        });
      } else {
        if (!num2.contains('.')) num2 += input;
        prevInput = '';
        setState(() {
          _finalResult = num2.substring(1);
          
        });
      }
    }
    else {
      if (operand == null) {
        num1 += input;
        prevInput = '';
        setState(() {
          _finalResult = num1.substring(1);
        });
      } else {
        num2 += input;
        prevInput = '';
        setState(() {
          _finalResult = num2.substring(1);
        });
      }
    }
  }

  Widget _buldGrid(String buttonText) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _process(buttonText);
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculator"),
          elevation: 0,
        ),
        body: Column(children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            alignment: Alignment.centerRight,
            width: double.infinity,
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey, width: 1),)
                ),
            child: Text((_finalResult.endsWith('.0') || _finalResult.endsWith('.00')) ? _finalResult.substring(0, _finalResult.indexOf('.')): _finalResult, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
          ),
          Row(
            children: [
              _buldGrid('7'),
              _buldGrid('8'),
              _buldGrid('9'),
              _buldGrid('/')
            ],
          ),
          Row(
            children: [
              _buldGrid('4'),
              _buldGrid('5'),
              _buldGrid('6'),
              _buldGrid('X')
            ],
          ),
          Row(
            children: [
              _buldGrid('1'),
              _buldGrid('2'),
              _buldGrid('3'),
              _buldGrid('-')
            ],
          ),
          Row(
            children: [
              _buldGrid('.'),
              _buldGrid('0'),
              _buldGrid('+'),
            ],
          ),
          Row(
            children: [
              _buldGrid('C'),
              _buldGrid('='),
            ],
          )
        ]));
  }
}
