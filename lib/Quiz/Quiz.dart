import 'package:flutter/material.dart';

//screeens

import 'Screens/questions.dart';
import 'Screens/Answer.dart';

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int index = 0;
  int totalScore = 0;

  void resetHandler() {
    setState(() {
      totalScore = 0;
      index = 0;
    });
  }

  void questionIndex(int score) {
    totalScore += score;
    setState(() {
      index += 1;
    });
    print(totalScore);
  }

  static const questions = [
    {
      'question': 'What\'s your favorite color',
      "answer": [
        {"options": 'red', "score": 5},
        {"options": 'yellow', "score": 8},
        {"options": 'blue', "score": 9},
        {"options": 'greeen', "score": 10},
      ],
    },
    {
      'question': 'What\'s your favorite animal',
      "answer": [
        {"options": 'Lion', "score": 6},
        {"options": 'Elephant', "score": 4},
        {"options": 'Horse', "score": 10},
        {"options": 'Rabbit', "score": 8},
      ],
    },
    {
      'question': 'What\'s your favorite Technology',
      "answer": [
        {"options": 'Reactjs', "score": 7},
        {"options": 'React-native', "score": 7},
        {"options": 'Flutter', "score": 9},
        {"options": 'Nodejs', "score": 8},
      ],
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Quiz App"),
      ),
      body: questions.length > index
          ? Questions(questionIndex, index, questions)
          : Answer(totalScore, resetHandler),
    );
  }
}
