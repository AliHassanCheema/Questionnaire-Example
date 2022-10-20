import 'dart:async';

import 'package:flutter/material.dart';
import 'package:questionnaire/ui/questionnaire_widgets/multi_line/multi_line_vm.dart';
import 'package:stacked/stacked.dart';

import '../../../models/get_questionnaire_model.dart';

class MultiLineVU extends ViewModelBuilderWidget<MultiLineViewModel> {
   MultiLineVU(this.questionnaire, this.controller,  {Key? key}) : super(key: key);
  final GetQuestionnaire questionnaire;
  late StreamController<String> controller;

  @override
  Widget builder(BuildContext context, MultiLineViewModel viewModel, Widget? child) {
    return Form(
      key: viewModel.formKey,
      child: TextFormField(
        onChanged: (value){
          viewModel.onSaved();
          questionnaire.answer = value;
        },
        initialValue: viewModel.questionnaire.answer ?? '',
        validator: viewModel.onValidate,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: 4,
        focusNode: viewModel.focus,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'don\'t_write_your_answer_here',
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 194, 194, 194),),),
      ),
    );
  }

  @override
  MultiLineViewModel viewModelBuilder(BuildContext context) {
    return MultiLineViewModel(questionnaire, controller);
  }
}