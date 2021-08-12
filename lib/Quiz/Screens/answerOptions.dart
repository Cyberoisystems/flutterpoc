import 'package:flutter/material.dart';

class AnswerOptions extends StatelessWidget {
  final String buttonName;
  final Function buttonIndex;
  AnswerOptions(this.buttonIndex, this.buttonName);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        color: Colors.blue,
        onPressed: () => buttonIndex(),
        child: Text(
          buttonName,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
