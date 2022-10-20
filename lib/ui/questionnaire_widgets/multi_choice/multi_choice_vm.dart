import 'package:stacked/stacked.dart';
import '../../../models/get_questionnaire_model.dart';

class MultiChoiceViewModel extends BaseViewModel{

  MultiChoiceViewModel(this.questionnaire);
  GetQuestionnaire questionnaire;


    onClickCheckBox( GetQuestionnaire questionnaire, int index, v, ){
      if (v == true){
      questionnaire.options![index].isCheck = v!;

      if(!isDataExist(questionnaire.options![index].option!)){
        questionnaire.selectedOption!.add(questionnaire.options![index].option!);
      }
    }else{
        questionnaire.options![index].isCheck = v!;

        if(isDataExist(questionnaire.options![index].option!)){
          questionnaire.selectedOption!.remove(questionnaire.options![index].option!);
        }
      }

    notifyListeners();
  }

  bool isChecked(String value){
    return isDataExist(value);
  }

bool isDataExist(String value) {
  // var data = selectedOptions.where((row) => (selectedOptions.contains(value)));
  var data = questionnaire.selectedOption!.where((row) => (questionnaire.selectedOption!.contains(value)));
  if (data.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

}