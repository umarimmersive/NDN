import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:national_digital_notes_new/models/Test_list_model.dart';

import 'Exam_model.dart';

class ExamCard extends StatelessWidget {
  final Test_list_model exam;

  const ExamCard({Key? key, required this.exam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0,right: 5.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(exam.title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        SizedBox(height: 2),
                        Text(exam.subject_name),
                        SizedBox(height: 20),
                        //Text("Date: ${DateFormat.yMMMd().format(exam.date)}"),

                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                     mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Time: ${exam.duration2} hr"),
                        SizedBox(height: 2),
                        Text("Date: ${exam.date}"),
                        SizedBox(height: 2),

                        Text(exam.payment_type=='unpaid' ? "${exam.payment_amount}" : exam.payment_type, style: TextStyle(color: exam.payment_type=='unpaid' ? Colors.red : Colors.green)),
                       // Text("Upcomimg", style: TextStyle(color: Colors.red))

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
