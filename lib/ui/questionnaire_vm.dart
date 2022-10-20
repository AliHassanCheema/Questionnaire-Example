import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../models/get_questionnaire_model.dart';

class QuestionnaireViewModel extends BaseViewModel {
  List<Answers> answers = [];
  List<GetQuestionnaire> questions = [];
  FocusNode focus = FocusNode();
  final notificationController = StreamController<String>.broadcast();

  QuestionnaireViewModel() {
    questions.add(GetQuestionnaire('ID', 'AP-ID', 'What is Your Problem?',
        'single_line', null, null, null));
    questions.add(GetQuestionnaire('ID1', 'AP-ID1', 'What is Your Problem?1',
        'multi_line', null, null, null));
    questions.add(GetQuestionnaire(
        'ID2',
        'AP-ID2',
        'What is Your Problem?2',
        'single_choice',
        null,
        [Options('Yes', false), Options('No', false)],
        ['No']));
    questions.add(GetQuestionnaire(
        'ID3',
        'AP-ID3',
        'What did You eat?',
        'multi_choice',
        null,
        [
          Options('Daal Chawal', false),
          Options('Savour Pulao', false),
          Options('Lassi', false),
          Options('Pizza', false)
        ],
        ['Daal Chawal', 'Pizza']));
  }

  onAddToList(Answers value) {
    // if (!isDataExist(value)) {
    //   answers.add(value);
    // }
    answers.removeWhere((row) => (row.questionId == value.questionId));
    answers.add(value);
    for (var answer in answers) {
      debugPrint(
          '${answer.answer}    ${answer.question}-------> ${answer.selectedOption}');
    }
    debugPrint('\n');
  }

  addData() {
    int i = 0;
    for (var question in questions) {
      debugPrint(question.answer);
      debugPrint(question.selectedOption.toString());
      if(question.answerType != 'single_line' && question.answerType != 'multi_line') {
        List<String>? option = question.options!
            .map((op) {
          return op.option;
        })
            .cast<String>()
            .toList();

        List<String> sOptions = question.selectedOption!.map((e) => e.toString()).toList();
        answers.add(Answers(
            questionId: question.questionId,
            question: question.question,
            answerType: question.answerType,
            answer: question.answer,
            options: option,
            selectedOption: sOptions ));
      }
      else{
        answers.add(Answers(
            questionId: question.questionId,
            question: question.question,
            answerType: question.answerType,
            answer: question.answer,
            options: null,
            selectedOption: null));
      }

      debugPrint(answers[i].answer);
      debugPrint(answers[i].selectedOption.toString());
      i++;
    }
  }

// bool isDataExist(Answers value) {
//   // var data = answers.where((row) => (answers.contains(value)));
//   var data = answers.where((row) => (answers.contains(value)));
//   if (data.length >= 1) {
//     return true;
//   } else {
//     return false;
//   }
// }
}
