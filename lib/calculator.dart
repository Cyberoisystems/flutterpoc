import 'package:flutter/material.dart';

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  late int firstNum;
  late int secondNum;
  late String res;
  late String opertor;
  String valueTodisplay = "";

  void buttonHandler(buttonVal) {
    if (buttonVal == "C") {
      res = "";
      firstNum = 0;
      secondNum = 0;
      opertor = "";
    } else if (buttonVal == "+" ||
        buttonVal == "-" ||
        buttonVal == "*" ||
        buttonVal == "/") {
      firstNum = int.parse(valueTodisplay);
      res = "";
      opertor = buttonVal;
    } else if (buttonVal == "=") {
      secondNum = int.parse(valueTodisplay);
      if (opertor == "+") {
        res = (firstNum + secondNum).toString();
      }
      if (opertor == "-") {
        res = (firstNum - secondNum).toString();
      }
      if (opertor == "*") {
        res = (firstNum * secondNum).toString();
      }
      if (opertor == "/") {
        res = (firstNum ~/ secondNum).toString();
      }
    } else {
      res = int.parse(valueTodisplay + buttonVal).toString();
    }
    setState(() {
      valueTodisplay = res;
    });
  }

  @override
  Widget buttonWidget(String buttonVal) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Expanded(
      child: OutlineButton(
        onPressed: () => buttonHandler(buttonVal),
        padding: isLandscape ? EdgeInsets.all(15) : EdgeInsets.all(30),
        child: Text(
          "$buttonVal",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      title: Text("Calculator"),
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          height: (MediaQuery.of(context).size.height -
                  appbar.preferredSize.height -
                  MediaQuery.of(context).padding.top) *
              1,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.all(10.0),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "$valueTodisplay",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: "Times new Roman",
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  buttonWidget("9"),
                  buttonWidget("8"),
                  buttonWidget("7"),
                  buttonWidget("+"),
                ],
              ),
              Row(
                children: [
                  buttonWidget("4"),
                  buttonWidget("5"),
                  buttonWidget("6"),
                  buttonWidget("-"),
                ],
              ),
              Row(
                children: [
                  buttonWidget("1"),
                  buttonWidget("2"),
                  buttonWidget("3"),
                  buttonWidget("*"),
                ],
              ),
              Row(
                children: [
                  buttonWidget("C"),
                  buttonWidget("."),
                  buttonWidget("="),
                  buttonWidget("/"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
