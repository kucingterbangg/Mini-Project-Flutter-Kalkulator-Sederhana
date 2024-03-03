import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFD291BC),
        appBar: AppBar(
          backgroundColor: Color(0xFF957DAD),
          title: Text(
            'Jess-Calculator',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(18.0),
          child: SizedBox(
            width: double.infinity,
            child: CalcButton(),
          ),
        ),
      ),
    );
  }
}

class CalcButton extends StatefulWidget {
  const CalcButton({Key? key}) : super(key: key);

  @override
  CalcButtonState createState() => CalcButtonState();
}

class CalcButtonState extends State<CalcButton> {
  double? _currentValue = 0;
  @override
  Widget build(BuildContext context) {
    var calc = SimpleCalculator(
      value: _currentValue!,
      hideExpression: false,
      hideSurroundingBorder: true,
      autofocus: true,
      onChanged: (key, value, expression) {
        setState(() {
          _currentValue = value ?? 0;
        });
        if (kDebugMode) {
          print('$key\t$value\t$expression');
        }
      },
      onTappedDisplay: (value, details) {
        if (kDebugMode) {
          print('$value\t${details.globalPosition}');
        }
      },
      theme: const CalculatorThemeData(
        borderColor: Color.fromARGB(255, 32, 13, 35),
        borderWidth: 2,
        displayColor: Color(0xFFFFDFD3),
        displayStyle:
            TextStyle(fontSize: 80, color: Color.fromARGB(255, 32, 13, 35)),
        expressionColor: Color(0xFFFEC8D8),
        expressionStyle: TextStyle(fontSize: 15, color: Colors.white),
        operatorColor: Color(0xFFD291BC),
        operatorStyle: TextStyle(fontSize: 30, color: Colors.white),
        commandColor: Color(0xFF957DAD),
        commandStyle: TextStyle(fontSize: 30, color: Colors.white),
        numColor: Color(0xFFE0BBE4),
        numStyle: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFEC8D8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              Color.fromARGB(255, 32, 13, 35), // Set the outline color to white
          width: 1.0, // Set the outline width to 1.0
        ),
      ),
      child: TextButton(
        child: Text(
          _currentValue.toString(),
          style: TextStyle(
            color: Colors
                .white, // Set the color of the text in the button to white
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: calc,
              );
            },
          );
        },
      ),
    );
  }
}
