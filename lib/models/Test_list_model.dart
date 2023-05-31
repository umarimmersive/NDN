class Test_list_model {
  String id;
  String title;
  String duration;
  String total_number_of_question;
  String payment_type;
  String marking_number;
  String negative_marking;
  String negative_marking_number;
  String passing_value;
  String instruction;
  String show_result;
  String total_mark;
  String time;
  String date;
  String payment_amount;
  String subject_name;
  String duration2;



  Test_list_model({
    required this.id,
    required this.title,
    required this.duration,
    required this.total_number_of_question,
    required this.payment_type,
    required this.marking_number,
    required this.negative_marking,
    required this.negative_marking_number,
    required this.passing_value,
    required this.instruction,
    required this.show_result,
    required this.total_mark,
    required this.time,
    required this.date,
    required this.payment_amount,
    required this.subject_name,
    required this.duration2,

  });

  factory Test_list_model.fromJson(Map userMap) {
    return Test_list_model(
      id: userMap['id'].toString()??'0',
      title: userMap['title'].toString()??'0',
      duration: userMap['duration'].toString()??'0',
      total_number_of_question: userMap['total_number_of_question'].toString()??'0',
      payment_type: userMap['payment_type'].toString()??'0',
      marking_number: userMap['marking_number'].toString()??'0',
      negative_marking: userMap['negative_marking'].toString()??'0',
      negative_marking_number: userMap['negative_marking_number'].toString()??'0',
      passing_value: userMap['passing_value'].toString()??'0',
      instruction: userMap['instruction'].toString()??'0',
      show_result: userMap['show_result'].toString()??'0',
      total_mark: userMap['total_mark'].toString()??'0',
      time: userMap['time'].toString()??'0',
      date: userMap['date'].toString()??'0',
      payment_amount: userMap['payment_amount'].toString()??'0',
      subject_name: userMap['subject_name'].toString()??'0',
      duration2: userMap['duration2'].toString()??'0',
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
