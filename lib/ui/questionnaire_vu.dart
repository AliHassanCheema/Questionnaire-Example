import 'package:flutter/material.dart';
import 'package:questionnaire/ui/questionnaire_vm.dart';
import 'package:questionnaire/ui/questionnaire_widgets/multi_choice/multi_choice_vu.dart';
import 'package:questionnaire/ui/questionnaire_widgets/multi_line/multi_line_vu.dart';
import 'package:questionnaire/ui/questionnaire_widgets/single_choice/single_choice_vu.dart';
import 'package:questionnaire/ui/questionnaire_widgets/single_line/single_line_vu.dart';
import 'package:stacked/stacked.dart';

import '../models/get_questionnaire_model.dart';

class QuestionnaireVU extends ViewModelBuilderWidget<QuestionnaireViewModel> {
  const QuestionnaireVU({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, QuestionnaireViewModel viewModel, Widget? child) {
    // return Scaffold(
    //   body: Padding(
    //     padding: const EdgeInsets.fromLTRB(20,16, 20, 20),
    //     child: ListView(
    //       children: [ExpansionPanelList(
    //         dividerColor: Colors.green,
    //
    //         expandedHeaderPadding: EdgeInsets.only(bottom: 0),
    //         expansionCallback: (int index, bool isExpanded){
    //           for(int i = 0; i<viewModel.questions.length; i++){
    //             viewModel.questions[i].isExpanded = false;
    //           }
    //
    //           viewModel.questions[index].isExpanded = !isExpanded;
    //           debugPrint('Expansion Index $index');
    //           viewModel.notifyListeners();
    //         },
    //         children:
    //
    //         viewModel.questions.map<ExpansionPanel>((e){
    //           return ExpansionPanel(
    //             canTapOnHeader: true,
    //               headerBuilder: (BuildContext context, bool isExpanded){
    //                 return ListTile(
    //                   title: Text(
    //                     e.question!,
    //                     maxLines: 4,
    //                     style: const TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 );
    //               },
    //               body: Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
    //                 child: Column(
    //                   children: [
    //                     const Divider(
    //                       color: Color.fromARGB(255, 194, 194, 194),
    //                     ),
    //                     e.answerType == 'single_line'
    //                         ? SingleLineVU(e, viewModel.onAddToList, viewModel.notificationController)
    //                         : e.answerType == 'multi_line'
    //                         ? MultiLineVU(e, viewModel.onAddToList, viewModel.notificationController)
    //                         : e.answerType == 'multi_choice'
    //                         ? MultiChoiceVU(e, viewModel.onAddToList, viewModel.notificationController)//MultiChoiceQuestion( questionnaire)
    //                         : SingleChoiceVU(e, viewModel.onAddToList, viewModel.notificationController),
    //                   ],
    //                 ),
    //               ),
    //               isExpanded: e.isExpanded);
    //         }).toList(),
    //       )],
    //     ),
    //   ),
    //   bottomSheet: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       ElevatedButton(
    //         onPressed: () {
    //           viewModel.focus.requestFocus();
    //           viewModel.answers.clear();
    //           viewModel.notificationController.sink.add('GetData');
    //         },
    //         focusNode: viewModel.focus,
    //         child: const Text('Get Focus'),
    //       ),
    //     ],
    //   ),
    // );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: questionBox(
                  context, viewModel, viewModel.questions[index], index)),
          itemCount: viewModel.questions.length,
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // viewModel.focus.requestFocus();
              viewModel.answers.clear();
              viewModel.notificationController.sink.add('GetData');
              viewModel.addData(context);
            },
            focusNode: viewModel.focus,
            child: const Text('Get Focus'),
          ),
        ],
      ),
    );
  }

  Widget questionBox(
    BuildContext context,
    QuestionnaireViewModel viewModel,
    GetQuestionnaire questionnaire,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: const Color.fromARGB(255, 216, 216, 216), width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: ExpansionTile(
            // key: PageStorageKey<GetQuestionnaire>(viewModel.questions[index]),
            // onExpansionChanged: (value){
            //   // for(int i = 0; i<viewModel.questions.length; i++){
            //     // viewModel.questions[i].isExpanded = false;
            //
            //   // }
            //
            //   viewModel.questions[index].isExpanded = !viewModel.questions[index].isExpanded;
            //   debugPrint('Expansion Index $index');
            //   viewModel.notifyListeners();
            // },
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            iconColor: Colors.black,
            textColor: Colors.black,
            initiallyExpanded: viewModel
                .questions[index].isExpanded, //index == 0 ? true : false,
            title: Text(
              questionnaire.question!,
              maxLines: 4,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              const Divider(
                color: Color.fromARGB(255, 194, 194, 194),
              ),
              questionnaire.answerType == 'single_line'
                  ? SingleLineVU(
                      questionnaire, viewModel.notificationController)
                  : questionnaire.answerType == 'multi_line'
                      ? MultiLineVU(
                          questionnaire, viewModel.notificationController)
                      : questionnaire.answerType == 'multi_choice'
                          ? MultiChoiceVU(
                              questionnaire) //MultiChoiceQuestion( questionnaire)
                          : SingleChoiceVU(questionnaire),
            ],
          ),
        ),
      ),
    );
  }

  @override
  QuestionnaireViewModel viewModelBuilder(BuildContext context) {
    return QuestionnaireViewModel();
  }
}
