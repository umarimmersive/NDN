import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import '../../../../utils/routes/app_pages.dart';
import '../controllers/TestList_controller.dart';
import 'ExamCard.dart';

class TestListView extends GetView<TestList_Controller> {
  const TestListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(controller.title.value),
        centerTitle: false,
      ),
      body: Obx((){
           if(controller.isLoading1.isTrue){
             return Center(child: CupertinoActivityIndicator());
           }else{
             if(controller.Test_list.isEmpty){
               return Center(
                 child: Text('No data found'),
               );
             }else{
               return  Column(
                 children: [
                   Expanded(
                     flex: 2,
                     child: Padding(
                       padding: const EdgeInsets.all(6.0),
                       child: Card(
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(6.0),
                         ),
                         elevation: 0,
                         child: Column(
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(16.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text('${controller.title.value}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                   InkWell(
                                     onTap: (){
                                       var data={
                                         'seriesID': controller.testId.toString()
                                       };
                                       Get.toNamed(Routes.TEST_RESULT_LIST,parameters: data);
                                     },
                                     child: Container(
                                         decoration: BoxDecoration(
                                           color: Colors.lightBlue,
                                           borderRadius: BorderRadius.circular(05),
                                         ),
                                         width: 100,
                                         height: 40,
                                         child: Center(child: Text('Result',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white)))),
                                   ),


                                 ],
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(top: 00.0,right: 16),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                                   //Text('Test Series 1',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                   InkWell(
                                     onTap: (){
                                       if(userData!.phoneNumber.isEmpty){
                                         String popupText = "Kindly updated your profile becuase there are some details are missing.  ";
                                         showTextPopup(context, popupText);

                                       }else{
                                         controller.incrementCounter(price: controller.total_amount.value.toString());
                                       }



                                     },
                                     child: Container(
                                         decoration: BoxDecoration(
                                           color: Colors.lightBlue,
                                           borderRadius: BorderRadius.circular(05),
                                         ),
                                         width: 160,
                                         height: 40,
                                         child: Center(child: Text('Buy All Course',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white)))),
                                   ),


                                 ],
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),

                   Expanded(
                     flex: 8,
                     child:  ListView.builder(
                       itemCount: controller.Test_list.length,
                       itemBuilder: (context, index) {
                         return InkWell(
                             onTap: (){
                               if(controller.Test_list[index].payment_amount!='0') {

                                 String popupText = "Now all the Online Test Exams is unpaid, if you want to purchase this so click on Buy All Course button.";
                                 showTextPopup(context, popupText);
                               } else{

                                 if(controller.Test_list[index].test_type.toString().toLowerCase()=='one' || controller.Test_list[index].test_type.toString().toLowerCase()=='multiple'){
                                   var data={
                                     'cochingId':controller.cochingId.value.toString(),
                                     'exam_title':controller.exam_title.value.toString(),
                                     'test_id':controller.testId.value.toString(),
                                     'seriesId':controller.Test_list[index].id.toString(),
                                     'instruction':controller.Test_list[index].instruction.toString(),
                                     'time':controller.Test_list[index].time.toString(),
                                     'duration2':controller.Test_list[index].duration2.toString(),
                                     'passing_value':controller.Test_list[index].passing_value.toString(),
                                     'total_number_of_question':controller.Test_list[index].total_number_of_question.toString(),
                                     'negative_marking_number':controller.Test_list[index].negative_marking_number.toString(),
                                     'negative_marking':controller.Test_list[index].negative_marking.toString(),
                                     'payment_type':controller.Test_list[index].payment_type.toString(),
                                     'subject_name':controller.Test_list[index].subject_name.toString(),
                                     'title':controller.Test_list[index].title.toString(),
                                     'show_result':controller.Test_list[index].show_result.toString(),
                                     'duration':controller.Test_list[index].duration.toString(),
                                     'date':controller.Test_list[index].date.toString(),
                                     'marking_number':controller.Test_list[index].marking_number.toString(),
                                     'payment_amount':controller.Test_list[index].payment_amount.toString(),
                                     'total_mark':controller.Test_list[index].total_mark.toString(),
                                     'Series_name':controller.Series_name.value.toString(),
                                   };

                                   Get.offAndToNamed(Routes.PRE_ONLINETEST_INSTRUCTION,parameters: data);
                                 }else{

                                   String popupText = "This Online Test Exam was only for one time attempt and you are already submitted this.";
                                   showTextPopup(context, popupText);

                                 }

                               }

                             },
                             child: ExamCard(exam: controller.Test_list[index]));
                       },
                     ),
                   ),

                 ],
               );
             }

             }
           }
      )
    );
  }

  void showTextPopup(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
          content: Text(text),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
               Get.back();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
