import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:national_digital_notes_new/app/modules/Test_result_list/views/pdf_viewer.dart';

import '../../../../utils/routes/app_pages.dart';
import '../controllers/test_result_list_controller.dart';

class TestResultListView extends GetView<TestResultListController> {
  const TestResultListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: ()async{
          Get.back();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text('Results'),

          ),
          body: Obx((){
                 if(controller.isLoading1.isTrue){
                   return Center(child: CupertinoActivityIndicator());
                 }else{
                   if(controller.Test_list.isNotEmpty){
                     return  Column(
                       children: [
                         // Expanded(
                         //   flex: 1,
                         //   child: Column(
                         //     children: [
                         //       Card(
                         //         shape: RoundedRectangleBorder(
                         //           borderRadius: BorderRadius.circular(0.0),
                         //         ),
                         //         elevation: 0,
                         //         child: Padding(
                         //           padding: const EdgeInsets.all(16.0),
                         //           child: Row(
                         //             mainAxisAlignment: MainAxisAlignment.center,
                         //             children: [
                         //               Text('Results',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                         //               //Text('Result',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                         //
                         //             ],
                         //           ),
                         //         ),
                         //       ),
                         //     ],
                         //   ),
                         // ),
                         Expanded(
                           flex: 1,
                           child: Padding(
                             padding: const EdgeInsets.only(top: 5.0,left: 6,right: 6),
                             child: GetBuilder<TestResultListController>(
                               init: TestResultListController(),
                               builder: (controller) => ListView.builder(
                                 itemCount: controller.Test_list.length,
                                 itemBuilder: (context, index) {
                                   return Padding(
                                     padding: const EdgeInsets.symmetric(vertical: 1.0),
                                     child: Card(
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(10.0),
                                       ),
                                       child: ListTile(
                                         title: Column(
                                           crossAxisAlignment: CrossAxisAlignment.end,
                                           children: [
                                             Padding(
                                               padding: const EdgeInsets.all(2.0),
                                               child: Text('${controller.Test_list[index].create_date}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300, color: Colors.black,)),
                                             ),


                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 // Text('Test 1',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.black,)),
                                                 Text('${controller.Test_list[index].title}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black,)),
                                                 ElevatedButton(
                                                   onPressed: () {
                                                     print('pdf-----${controller.Test_list[index].answer_pdf}');
                                                     Get.to(TestingPDF2(pdf_url: controller.Test_list[index].answer_pdf,));
                                                   },
                                                   child: Padding(
                                                     padding: const EdgeInsets.only(left: 20.0,right:20 ),
                                                     child: Text('Solution'),
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ],
                                         ),
                                         subtitle: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             SizedBox(
                                               height: 5,
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text('Obtained:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.black,)),
                                                 Text('${controller.Test_list[index].accuracy}%',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black,)),
                                               ],
                                             ),
                                             // Text('Obtained: ${controller.results[index].obtained}'),
                                             SizedBox(
                                               height: 5,
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text('Rank:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.black,)),
                                                 Text('${controller.Test_list[index].rank}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black,)),
                                               ],
                                             ),
                                             // Text('Rank: ${controller.results[index].rank}'),
                                             SizedBox(
                                               height: 5,
                                             ),

                                             //
                                           ],
                                         ),
                                       ),
                                     ),
                                   );
                                 },
                               ),
                             ),
                           ),
                         ),
                       ],
                     );
                   }else{
                     return Center(child: Text('No data found.'),);
                   }


                 }
              })




        ),
      );


  }
}
