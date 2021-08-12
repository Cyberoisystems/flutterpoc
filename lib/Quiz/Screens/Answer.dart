import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final int totalScore;
  final Function resetHandler ;
  Answer(this.totalScore , this.resetHandler);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Hey , Your Score is $totalScore",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          OutlineButton(
            onPressed: () => resetHandler(),
            child: Text(
              "Restart Quiz",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
