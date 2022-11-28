import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/get_questionnaire_model.dart';

class MultiLineViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode focus = FocusNode();
  Answers? answer;
  String myAnswer = '';
  final GetQuestionnaire questionnaire;
  late StreamController<String> controller;
  late StreamSubscription subscription;

  MultiLineViewModel(this.questionnaire, this.controller) {
    // focus.addListener(onFocusChanged);
    subscription = controller.stream.listen((String data) {
      if (answer == null) {
        if (!formKey.currentState!.validate()) {
          debugPrint('Error');
          return;
        }
      }
    });
  }

  void onFocusChanged() {
    debugPrint('Focus: ${focus.hasFocus.toString()}');
    if (!focus.hasFocus) {
      onSaved();
    }
  }

  String? onValidate(value) {
    if (value == null || value.isEmpty) {
      return 'Mandatory field*';
    }
    myAnswer = value;
    return null;
  }

  void onSaved() {
    if (!formKey.currentState!.validate()) {
      debugPrint('Error');
      return;
    }
    debugPrint('Pass');
    // answer = Answers(questionId: questionnaire.questionId, question: questionnaire.question, answerType: questionnaire.answerType, answer: myAnswer, options: null, selectedOption: null);
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
    focus.removeListener(onFocusChanged);
    focus.dispose();
  }
}
