class Question_db_nodel{
  String? id;
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

  Question_db_nodel({
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


  factory Question_db_nodel.fromJson(Map userMap) {
    return Question_db_nodel(
      id: userMap['id'].toString()??'0',
      question: userMap['question'].toString()??'0',
      question_hindi: userMap['question_hindi'].toString()??'0',
      options_hindi: userMap['options_hindi'].toString()??'0',
      options: userMap['options'].toString()??'0',
      answer_index_hindi: userMap['answer_index_hindi'].toString()??'0',
      user_answer: userMap['user_answer'].toString()??'0',
      type: userMap['type'].toString()??'0',
      answerIndex: userMap['answerIndex'].toString()??'0',
      markforreview: userMap['markforreview'].toString()??'0',
      is_question_image: userMap['is_question_image'].toString()??'0',
      question_image: userMap['question_image'].toString()??'0',
      option_image: userMap['option_image'].toString()??'0',
      is_option_image: userMap['is_option_image'].toString()??'0',
    );
  }
}