import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/get_questionnaire_model.dart';

class SingleChoiceViewModel extends BaseViewModel {

  onRadioBtn(String? value, GetQuestionnaire questionnaire) {
    // v = value!;
    questionnaire.selectedOption![0] = value!;
    // List<Options>? options = questionnaire.options;
    // List<String>? option = options!
    //     .map((op) {
    //       return op.option;
    //     })
    //     .cast<String>()
    //     .toList();
    // List<String> optionsss = [value];
    // answer = Answers(
    //     questionId: questionnaire.questionId,
    //     question: questionnaire.question,
    //     answerType: questionnaire.answerType,
    //     options: option,
    //     selectedOption: optionsss);
    notifyListeners();
  }
}
