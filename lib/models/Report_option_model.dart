class Report_option_model {
  String id;
  String name;


  Report_option_model({
    required this.id,
    required this.name,


  });

  factory Report_option_model.fromJson(Map userMap) {
    return Report_option_model(
      id: userMap['id'].toString()??'0',
      name: userMap['name'].toString()??'0',


    );
  }



}
/*
[{id: 1, title: Test 1, exam_type_id: 0, coaching_id: 81, exam_id: 11},
{id: 2, title: Test 2, exam_type_id: 0, coaching_id: 81, exam_id: 11}]}*/
