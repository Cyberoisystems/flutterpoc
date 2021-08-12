import 'package:flutter/material.dart';

class QuestionsList extends StatelessWidget {
  final String questions;
  QuestionsList(this.questions);
  @override
  Widget build(BuildContext context) {
    return Container( 
      margin: EdgeInsets.all(10),
      width: double.infinity,  
      child: Text(
        questions,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        ),
    );
  }
}
