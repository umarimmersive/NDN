import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Exam_model.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(exam.number,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      SizedBox(height: 2),
                      Text(exam.name),
                      SizedBox(height: 20),
                      //Text("Date: ${DateFormat.yMMMd().format(exam.date)}"),

                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Time: ${exam.time}"),
                      SizedBox(height: 2),
                      Text("Date: ${exam.date}"),
                      SizedBox(height: 2),
                      exam.Status?

                      Text(exam.isPaid ? "Paid ₹100" : "Unpaid", style: TextStyle(color: exam.isPaid ? Colors.green : Colors.red)):
                      Text("Upcomimg", style: TextStyle(color: Colors.red))

                    ],
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
