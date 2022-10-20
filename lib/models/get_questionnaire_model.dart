class GetQuestionnaire{
  String? questionId;
  String? appointmentId;
  String? question;
  String? answerType;
  String? answer;
  List<Options>? options;
  List<dynamic>? selectedOption;
  bool isExpanded = false;


  GetQuestionnaire(this.questionId,this.appointmentId,this.question,this.answerType,this.answer,this.options,this.selectedOption);

  factory GetQuestionnaire.fromMap(Map<String, dynamic> resp,) {
    final List<dynamic>? option = resp['options'];
    List<Options>? options;
    if(option != null){
      options =  option.map((op){
        return Options(op, false);
      }).toList();
    }
    return GetQuestionnaire(
      resp['question_id'] as String?,
      resp['appointment_id'] as String?,
      resp['question'] as String?,
      resp['answer_type'] as String?,
      resp['answer'] as String?,
      resp['options'] == null ? null : options,
      resp['selected_option'] as List<dynamic>?,
    );
  }
}


class CreateQuestionair {
  String? appointmentId;
  List<Answers>? answers;

  CreateQuestionair({this.appointmentId, this.answers});

  CreateQuestionair.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add( Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['appointment_id'] = appointmentId;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  String? questionId;
  String? question;
  String? answerType;
  String? answer;
  List<String>? options;
  List<String>? selectedOption;

  Answers(
      {this.questionId,
        this.question,
        this.answerType,
        this.answer,
        this.options,
        this.selectedOption});

  Answers.fromJson(Map<String, dynamic> json) {

    question = json['question'];
    answerType = json['answer_type'];
    answer = json['answer'];
    options = json['options'].cast<String>();
    selectedOption = json['selected_option'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer_type'] = answerType;
    data['answer'] = answer;
    data['options'] = options;
    data['selected_option'] = selectedOption;
    return data;
  }
}

class Options{
  String? option;
  bool? isCheck = false;

  Options(this.option,this.isCheck);

  static Options fromMap(Map<String , dynamic>resp){
    return Options(
      resp['options'] as String,
      resp['is_check'] as bool,
    );
  }
}
