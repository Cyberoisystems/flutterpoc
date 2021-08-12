import 'package:flutter/material.dart';

//Screens

import 'questionsList.dart';
import 'answerOptions.dart';

class Questions extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final index;
  final Function questionIndex;
  Questions(this.questionIndex, this.index, this.questions);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            QuestionsList((questions[index]['question'] as String)),
            ...(questions[index]['answer'] as List<Map<String, Object>>)
                .map((item) {
              print(item);
              return AnswerOptions(() => questionIndex(item['score']),
                  item['options'] as String);
            }).toList()
          ],
        ),
      ),
    );
  }
}
