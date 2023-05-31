class getExamList {
  String id;
  String title;
  String exam_type_id;



  getExamList({
    required this.id,
    required this.title,
    required this.exam_type_id,

  });

  factory getExamList.fromJson(Map userMap) {
    return getExamList(
      id: userMap['id'].toString()??'0',
      title: userMap['title'].toString()??'0',
      exam_type_id: userMap['exam_type_id'].toString()??'0',


    );
  }



}
/*
[{id: 1, title: Test 1, exam_type_id: 0, coaching_id: 81, exam_id: 11},
{id: 2, title: Test 2, exam_type_id: 0, coaching_id: 81, exam_id: 11}]}*/
