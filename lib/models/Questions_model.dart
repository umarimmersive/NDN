

class Questions {
  static final List<String> values = [
    /// Add all fields
    id, question, question_hindi, options_hindi, answerIndex ,answer_index_hindi ,options ,user_answer,type ,markforreview
  ];
  static const String id = 'id';
  static const String question = 'question';
  static const String question_hindi = 'question_hindi';
  static const String options_hindi = 'options_hindi';
  static const String answerIndex ='answerIndex';
  static const String answer_index_hindi ='answer_index_hindi';
  static const String options ='options';
  static const String user_answer ='user_answer';
  static const String type ='type';
  static const String markforreview ='markforreview';


  //static final List<String> options = [];
}

class Questions_model{
  int? id;
  String? question;
  String? question_hindi;
  String? options_hindi;
  String? answer_index_hindi;
  String? options;
  String? answerIndex;
  String? user_answer;
  String? type;
  String? markforreview;

  Questions_model({
    this.id,
    this.question,
    this.question_hindi,
    this.options_hindi,
    this.options,
    this.answer_index_hindi,
    this.user_answer,
    this.type,
    this.answerIndex,
    this.markforreview,
  });

  Questions_model.fromMap(Map<String, dynamic> item):
        id=item[Questions.id],
        options = item[Questions.options],
        question_hindi = item[Questions.question_hindi],
        options_hindi = item[Questions.options_hindi],
        question = item[Questions.question],
        user_answer = item[Questions.user_answer].toString(),
        answerIndex = item[Questions.answerIndex].toString(),
        answer_index_hindi = item[Questions.answer_index_hindi].toString(),
        type = item[Questions.type].toString(),
        markforreview = item[Questions.markforreview].toString();

  Map<String, Object> toMap(){
    return {
      Questions.id: id??'',
      Questions.question: question??'',
      Questions.question_hindi: question_hindi??'',
      Questions.options_hindi: options_hindi??'',
      Questions.user_answer: user_answer??'',
      Questions.type: type??'',
      Questions.answerIndex: answerIndex.toString()??'',
      Questions.answer_index_hindi: answer_index_hindi.toString()??'',
      Questions.options: options??'',
      Questions.markforreview: markforreview??'',
    };
  }
}