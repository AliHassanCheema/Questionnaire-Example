import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/get_questionnaire_model.dart';

class SingleLineViewModel extends BaseViewModel
{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode focus = FocusNode();
  Answers? answer;
  String myAnswer = '';
  GetQuestionnaire questionnaire;
  late StreamController<String> controller;
  late StreamSubscription subscription;


  SingleLineViewModel(this.questionnaire, this.controller)
  {
    debugPrint('Build is being called IN VM');

    // focus.addListener(onFocusChanged);
    subscription = controller.stream.listen((String data) {
      if(answer == null){
        if(!formKey.currentState!.validate())
        {
          debugPrint('Error');
          return;
        }
      }
    });
  }

  void onFocusChanged()
  {
    debugPrint('Focus: ${focus.hasFocus.toString()}');
    if(!focus.hasFocus){
      onSaved();
    }
  }

  String? onValidate(value)
  {
    if (value == null || value.isEmpty) {
      return 'please enter some answer';
    }
    myAnswer = value;
    return null;
  }

  void onSaved()
  {
    if(!formKey.currentState!.validate())
      {
        debugPrint('Error');
        return;
      }
    debugPrint('Pass');
    // questionnaire.answer = myAnswer;
    // answer = Answers(questionId: questionnaire.questionId, question: questionnaire.question, answerType: questionnaire.answerType, answer: myAnswer, options: null, selectedOption: null);
  }


  @override
  void dispose() {
    subscription.cancel();
    focus.removeListener(onFocusChanged);
    focus.dispose();
  }
}