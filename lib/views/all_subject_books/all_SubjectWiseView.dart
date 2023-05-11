import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/detailed_course_screen/detailed_course_controller.dart';
import '../../utils/constants/api_service.dart';
import '../../utils/routes/app_pages.dart';


import 'package:http/http.dart' as http;
// ignore: must_be_immutable
/*class SubjectWiseView extends StatefulWidget {
  String subjectName;
  String coachingName;
  String subjectId;
  String examType;
  bool isHome;
  String id;


  SubjectWiseView({super.key,
    required this.isHome,
    required this.id,
    required this.coachingName,
    required this.subjectId,
    required this.examType,
    required this.subjectName});

  @override
  State<SubjectWiseView> createState() => _SubjectWiseViewState();
}*/

class all_SubjectWiseView extends GetView<detailed_course_controller> /*with SingleTickerProviderStateMixin*/ {



  @override
  Widget build(BuildContext context) {
  //  print("examType===============${controller.examType}");
    return
    Obx((){
     return Scaffold(
        backgroundColor: Colors.blue.shade50,
        body:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "English",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: controller.englishPressed == true
                            ? Colors.blue
                            : Colors.black),
                  ),
                  Switch(
                      value: controller.englishPressed == false ? true : false,
                      activeTrackColor: Colors.blue.shade200,
                      onChanged: (value) async{
                        controller.englishPressed.value = !controller.englishPressed.value;
                        await controller.book_List();
                        print("englishPressed=========================${controller.englishPressed}");
                      }),
                  Text(
                    "Hindi",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: controller.englishPressed == false
                            ? Colors.blue
                            : Colors.black),
                  )
                ],
              ),
            ),
            controller.isLoading==false?
            controller.bookList['success']!=false?
            Expanded(
              child: GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  primary: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2,
                      crossAxisCount: 2,
                      childAspectRatio: 0.45
                  ),
                  itemCount: controller.bookList['data'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {


                        print("===============bookkkk=====ontap");


                        var data={
                          "notedetails": "false",
                          "bookid": controller.bookList['data'][index]['id'].toString(),
                          "free": "false",
                          //"category":"${controller.subjectName}, ${controller.coachingName} ${controller.examType}",
                          "category":"${controller.bookList['data'][index]['book_name'].toString()}, ${controller.bookList['data'][index]['book_name'].toString()} ${controller.bookList['data'][index]['heading'].toString()}",

                          "bookName": controller.bookList['data'][index]['heading'].toString()??"",
                          "imageURL":  ApiService.IMAGE_URL+"${controller.bookList['data'][index]['image']}"
                        };

                        Get.toNamed(Routes.SPECIFIC_BOOK_VIEW,parameters: data);

                        print("===============bookkkk=====ontap");

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 7,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              //padding: const EdgeInsets.only(right: 10),
                              color: Colors.transparent,
                              alignment: Alignment.bottomRight,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.55,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      controller.englishPressed == true
                                          ? ApiService.IMAGE_URL+"${controller.bookList['data'][index]['image']}"
                                          : ApiService.IMAGE_URL+"${controller.bookList['data'][index]['image']}",
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        controller.bookList['data'][index]['book_name'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ):
            Expanded(child: Center(child: Text("No data found"))):
            Expanded(
              child: Center(
                child:   CupertinoActivityIndicator(),
              ),
            )


          ],
        ),
      );

    });


  }
}
