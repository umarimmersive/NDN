

class Questions {
  static final List<String> values = [
    /// Add all fields
    id, question, question_hindi, options_hindi, answerIndex ,answer_index_hindi ,options ,user_answer,type ,markforreview , is_question_image, question_image, option_image,is_option_image,
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
  static const String is_question_image ='is_question_image';
  static const String question_image ='question_image';
  static const String option_image ='option_image';
  static const String is_option_image ='is_option_image';


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
  String? is_question_image;
  String? question_image;
  String? option_image;
  String? is_option_image;

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
    this.is_question_image,
    this.question_image,
    this.option_image,
    this.is_option_image,
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
        markforreview = item[Questions.markforreview].toString(),
        is_question_image = item[Questions.is_question_image].toString(),
        question_image = item[Questions.question_image].toString(),
        option_image = item[Questions.option_image],
        is_option_image = item[Questions.is_option_image].toString();

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
      Questions.is_question_image: is_question_image.toString()??'',
      Questions.question_image: question_image??'',
      Questions.option_image: option_image??'',
      Questions.is_option_image: is_option_image??'',
    };
  }
}