import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../models/get_questionnaire_model.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class QuestionnaireViewModel extends BaseViewModel {
  List<Answers> answers = [];
  List<GetQuestionnaire> questions = [];
  FocusNode focus = FocusNode();
  final notificationController = StreamController<String>.broadcast();

  QuestionnaireViewModel() {
    questions.add(GetQuestionnaire(
        'ID', 'AP-ID', 'What happened?', 'single_line', null, null, null));
    questions.add(GetQuestionnaire(
        'ID1',
        'AP-ID1',
        "Please explain what's wrong with you?",
        'multi_line',
        null,
        null,
        null));
    questions.add(GetQuestionnaire(
        'ID2',
        'AP-ID2',
        'Would you like to tell me its reason?',
        'single_choice',
        null,
        [Options('Yes', false), Options('No', false)],
        ['No']));
    questions.add(GetQuestionnaire('ID3', 'AP-ID3',
        'Who creates problems for you?', 'multi_choice', null, [
      Options('Boss', false),
      Options('Job', false),
      Options('Team Lead', false),
      Options('Colleagues', false)
    ], [
      'Job',
      'Boss'
    ]));
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

  addData(BuildContext context) {
    int i = 0;
    for (var question in questions) {
      debugPrint(question.answer);
      debugPrint(question.selectedOption.toString());
      if (question.answerType != 'single_line' &&
          question.answerType != 'multi_line') {
        List<String>? option = question.options!
            .map((op) {
              return op.option;
            })
            .cast<String>()
            .toList();

        List<String> sOptions =
            question.selectedOption!.map((e) => e.toString()).toList();
        answers.add(Answers(
            questionId: question.questionId,
            question: question.question,
            answerType: question.answerType,
            answer: question.answer,
            options: option,
            selectedOption: sOptions));
      } else {
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
  onSuccessDialog(
      BuildContext context, double width, String title, String msg) {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        material: (_, __) => MaterialAlertDialogData(
          insetPadding: const EdgeInsets.all(10),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 28,
            ),
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Builder(builder: (context) {
            return SizedBox(
              width: width,
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }),
        ),
      ),
    );
  }
}
