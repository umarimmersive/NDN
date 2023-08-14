class Test_result_list_model {
  String id;
  String answer_pdf;
  String total_score;
  String title;
  String accuracy;
  String rank;
  String create_date;



  Test_result_list_model({
    required this.id,
    required this.answer_pdf,
    required this.total_score,
    required this.title,
    required this.accuracy,
    required this.rank,
    required this.create_date,


  });

  factory Test_result_list_model.fromJson(Map userMap) {
    return Test_result_list_model(
      id: userMap['id'].toString()??'0',
      answer_pdf: userMap['answer_pdf'].toString()??'0',
      total_score: userMap['total_score'].toString()??'0',
      title: userMap['title'].toString()??'0',
      accuracy: userMap['accuracy'].toString()??'0',
      rank: userMap['rank'].toString()??'0',
      create_date: userMap['create_date'].toString()??'0',

    );
  }



}
/*
{id: 1, title: UPSE 1, duration: 10,
total_number_of_question: 20, payment_type: Paid, marking_number: 1,
negative_marking: Yes, negative_marking_number: 1, passing_value: 5,
instruction: NA, show_result: Yes,
total_mark: 20, time: 10:00 AM, date: 2023-05-24, payment_amount: 0,
subject_name: Math Exam}*/
