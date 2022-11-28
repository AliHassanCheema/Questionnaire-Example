import 'dart:async';

import 'package:flutter/material.dart';
import 'package:questionnaire/models/get_questionnaire_model.dart';
import 'package:questionnaire/ui/questionnaire_widgets/single_line/single_line_vm.dart';
import 'package:stacked/stacked.dart';

class SingleLineVU extends ViewModelBuilderWidget<SingleLineViewModel> {
  const SingleLineVU(this.questionnaire, this.controller, {Key? key})
      : super(key: key);
  final GetQuestionnaire questionnaire;
  final StreamController<String> controller;

  @override
  Widget builder(
      BuildContext context, SingleLineViewModel viewModel, Widget? child) {
    debugPrint('Build is being called');
    return Form(
      key: viewModel.formKey,
      child: TextFormField(
        onChanged: (value) {
          viewModel.onSaved();
          questionnaire.answer = value;
        },
        initialValue: viewModel.questionnaire.answer ??
            (viewModel.answer == null ? '' : viewModel.answer!.answer),
        validator: viewModel.onValidate,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: 1,
        focusNode: viewModel.focus,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'write your answer here...',
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 194, 194, 194),
          ),
        ),
      ),
    );
  }

  @override
  SingleLineViewModel viewModelBuilder(BuildContext context) {
    return SingleLineViewModel(questionnaire, controller);
  }
}
