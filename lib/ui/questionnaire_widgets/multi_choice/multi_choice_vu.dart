import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/get_questionnaire_model.dart';
import 'multi_choice_vm.dart';

class MultiChoiceVU extends ViewModelBuilderWidget<MultiChoiceViewModel> {
  const MultiChoiceVU( this.questionnaire,  {Key? key}) : super(key: key);
  final GetQuestionnaire questionnaire;

  @override
  Widget builder(BuildContext context, MultiChoiceViewModel viewModel, Widget? child) {
    return
      ListView.builder(
          itemCount: questionnaire.options!.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context,index){
              return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(questionnaire.options![index].option!),
                  value: viewModel.isChecked(questionnaire.options![index].option!),//questionnaire.options![index].isCheck,
                  onChanged: (v){
                    viewModel.onClickCheckBox(questionnaire, index, v);
                  });
            }
          );
  }
  
  @override
  MultiChoiceViewModel viewModelBuilder(BuildContext context) {
    return MultiChoiceViewModel(questionnaire);
  }

}
