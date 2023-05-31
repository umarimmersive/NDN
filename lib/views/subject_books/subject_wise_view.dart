import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/controllers/detailed_booklist.dart';
import 'package:national_digital_notes_new/views/subject_books/subject_wise_view_controller.dart';

import '../../utils/constants/api_service.dart';
import '../../utils/routes/app_pages.dart';
import '../specific_book_details_screen/specific_books_views.dart';
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

class SubjectWiseView extends GetView<subject_wise_view_controller> /*with SingleTickerProviderStateMixin*/ {





  @override
  Widget build(BuildContext context) {
    print("examType===============${controller.examType}");
    return
    Obx((){

      if(controller.isHome=='true'){
        if( controller.examType.isEmpty){
          return Scaffold(
            backgroundColor: Colors.blue.shade50,
            appBar: AppBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.subjectName.value,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    "${controller.coachingName}, ${controller.examType}",
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
            body:  Column(

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
                            await  controller.callApi();

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
                controller.coachingNotes_isLoading==false?
                controller.coachingNotes['success']==true?

                Expanded(
                  child: GridView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    primary: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 2,
                        crossAxisCount: 2,
                        childAspectRatio: 0.6),
                    children: [
                      for(int index=0;index< controller.coachingNotes['data'].length;index++)
                        if(controller.coachingNotes['data'][index]['exam_type'].toString()=='')(
                            InkWell(
                              onTap: () {

                                var data={
                                  "notedetails": "true",
                                  "bookid": controller.coachingNotes['data'][index]['id'].toString(),
                                  "free": "false",
                                  "category":"${controller.subjectName}, ${controller.coachingName} ${controller.examType}",
                                  "bookName": controller.coachingNotes['data'][index]['title'].toString()??"",
                                  "imageURL":  "${ApiService.IMAGE_URL+controller.coachingNotes['data'][index]['image']}"
                                };

                                Get.toNamed(Routes.SPECIFIC_BOOK_VIEW,parameters: data);

                              },
                              child: Obx(
                                    ()=>controller.coachingNotes['data'] == null?
                                const Center(child: CupertinoActivityIndicator()):
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Card(
                                    elevation: 3,
                                    color: Colors.white,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      color: Colors.transparent,
                                      alignment: Alignment.bottomRight,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                              controller.englishPressed == true
                                                  ? '${ApiService.IMAGE_URL+controller.coachingNotes['data'][index]['image']}'
                                                  : '${ApiService.IMAGE_URL+controller.coachingNotes['data'][index]['image']}',
                                              fit: BoxFit.contain,
                                            ),
                                          ),

                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${controller.coachingNotes['data'][index]['title']}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        )

                    ],
                  ),
                )
                    :
                Expanded(child: Center(child: Text('Data not found'),)):

                Expanded(
                  child: Center(
                    child:   CupertinoActivityIndicator(),
                  ),
                )

              ],
            ),
          );
        }else{
          return Scaffold(
            backgroundColor: Colors.blue.shade50,
            appBar: AppBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.subjectName.value,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    "${controller.coachingName}, ${controller.examType}",
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),

              // overflow menu

              bottom: TabBar(
                controller: controller.tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.white,
                isScrollable: true,
                indicatorPadding: const EdgeInsets.symmetric(vertical: 8),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey.shade400,
                tabs: [
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    child: const Tab(text: "Pre"),
                  ),
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    child: const Tab(text: "Mains"),
                  ),
                ],
              ),
            ),
            body:  TabBarView(
              controller: controller.tabController,
              children: [
                Column(
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
                                await  controller.callApi();

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
                    controller.coachingNotes_isLoading==false?
                    controller.coachingNotes['success']!=false?
/*
                 Expanded(
                   child: GridView(

                       shrinkWrap: true,
                       padding: EdgeInsets.zero,
                       physics: const AlwaysScrollableScrollPhysics(),
                       primary: true,
                       scrollDirection: Axis.vertical,
                       gridDelegate:
                       const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisSpacing: 2,
                           crossAxisCount: 2,
                           childAspectRatio: 0.6),
                       itemCount: coachingNotes['data'].length,
                       itemBuilder: (BuildContext context, int index) {
                         if(coachingNotes['data'][index]['exam_type'].toString()=='Pre'|| coachingNotes['data'][index]['exam_type'].toString()=='Pre ,Main'){
                           return InkWell(
                             onTap: () {
                               print("-----------------");
                               Get.to(
                                   SpecificBooksViews(
                                     notedetails:true,
                                     bookid: '${coachingNotes['data'][index]['id']}',
                                     free: false,
                                     category:
                                     "${widget.subjectName}, ${widget
                                         .coachingName} ${widget.examType}",
                                     bookName:  coachingNotes['data'][index]['title']??"",
                                     imageURL:  "https://ndn.manageprojects.in/${coachingNotes['data'][index]['image']}",
                                   ));
                               // Get.to(SubjectWiseView(
                               //   coachingName: '${widget.map['name'][widget.index]}',
                               //   examType:
                               //   '${dashboardController.examCategories.value}',
                               //   subjectName:
                               //   '${coursesNames['name'][index].toString()}',
                               // ));
                             },
                             child: Obx(
                                   ()=>coachingNotes['data'] == null?
                               const Center(child: CupertinoActivityIndicator()):
                               Padding(
                                 padding: const EdgeInsets.all(4.0),
                                 child: Card(
                                   elevation: 3,
                                   color: Colors.white,
                                   child: Container(
                                     padding: const EdgeInsets.all(10),
                                     color: Colors.transparent,
                                     alignment: Alignment.bottomRight,
                                     child: Column(
                                       mainAxisAlignment:
                                       MainAxisAlignment.center,
                                       crossAxisAlignment:
                                       CrossAxisAlignment.center,
                                       children: [
                                         SizedBox(
                                           width: double.maxFinite,
                                           height: MediaQuery.of(context).size.height * 0.2,
                                           child: CachedNetworkImage(
                                             imageUrl:
                                             englishPressed == true
                                                 ? 'https://ndn.manageprojects.in/${coachingNotes['data'][index]['image']}'
                                                 : 'https://ndn.manageprojects.in/${coachingNotes['data'][index]['image']}',
                                             fit: BoxFit.contain,
                                           ),
                                         ),
                                         const SizedBox(
                                           height: 5,
                                         ),
                                         Container(
                                             alignment: Alignment.center,
                                             child: Text(
                                               '${coachingNotes['data'][index]['title']}',
                                               textAlign: TextAlign.center,
                                               style: const TextStyle(
                                                   fontSize: 13,
                                                   fontWeight: FontWeight.w600),
                                             )),
                                       ],
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                           );
                         }
                         return SizedBox();
                       }),
                 )*/
                    Expanded(
                      child: GridView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const AlwaysScrollableScrollPhysics(),
                        primary: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 2,
                            crossAxisCount: 2,
                            childAspectRatio: 0.6),
                        children: [
                          for(int index=0;index< controller.coachingNotes['data'].length;index++)
                            if(controller.coachingNotes['data'][index]['exam_type'].toString()=='Pre'|| controller.coachingNotes['data'][index]['exam_type'].toString()=='Pre, Main')(
                                InkWell(
                                  onTap: () {
                                    print("-----------------");

                                    var data={
                                      "notedetails": "true",
                                      "bookid": controller.coachingNotes['data'][index]['id'].toString(),
                                      "free": "false",
                                      "category":"${controller.subjectName}, ${controller.coachingName} ${controller.examType}",
                                      "bookName": controller.coachingNotes['data'][index]['title'].toString()??"",
                                      "imageURL":  "${ApiService.IMAGE_URL+controller.coachingNotes['data'][index]['image']}"
                                    };

                                    Get.toNamed(Routes.SPECIFIC_BOOK_VIEW,parameters: data);

                                  },
                                  child: Obx(
                                        ()=>controller.coachingNotes['data'] == null?
                                    const Center(child: CupertinoActivityIndicator()):
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Card(
                                        elevation: 3,
                                        color: Colors.white,
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          color: Colors.transparent,
                                          alignment: Alignment.bottomRight,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: double.maxFinite,
                                                height: MediaQuery.of(context).size.height * 0.2,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                  controller.englishPressed == true
                                                      ? '${ApiService.IMAGE_URL+controller.coachingNotes['data'][index]['image']}'
                                                      : '${ApiService.IMAGE_URL+controller.coachingNotes['data'][index]['image']}',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '${controller.coachingNotes['data'][index]['title']}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            )

                        ],
                      ),
                    )
                        :
                    Expanded(child: Center(child: Text(controller.coachingNotes['message']),)):
                    Expanded(
                      child: Center(
                        child:   CupertinoActivityIndicator(),
                      ),
                    )

                  ],
                ),
                Column(
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
                                await  controller.callApi();

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
                    controller.coachingNotes_isLoading==false?
                    controller.coachingNotes['success']!=false?
                    Expanded(
                      child: GridView(

                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const AlwaysScrollableScrollPhysics(),
                        primary: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 2,
                            crossAxisCount: 2,
                            childAspectRatio: 0.6),
                        children: [
                          for(int index=0;index< controller.coachingNotes['data'].length;index++)
                            if(controller.coachingNotes['data'][index]['exam_type'].toString()=='Main'|| controller.coachingNotes['data'][index]['exam_type'].toString()=='Pre, Main')(
                                InkWell(
                                  onTap: () {
                                    print("-----------------");


                                    var data={
                                      "notedetails": "true",
                                      "bookid": controller.coachingNotes['data'][index]['id'].toString(),
                                      "free": "false",
                                      "category":"${controller.subjectName}, ${controller.coachingName} ${controller.examType}",
                                      "bookName": controller.coachingNotes['data'][index]['title'].toString()??"",
                                      "imageURL":  "${ApiService.IMAGE_URL+controller.coachingNotes['data'][index]['image']}"
                                    };

                                    Get.toNamed(Routes.SPECIFIC_BOOK_VIEW,parameters: data);

                                  },
                                  child: Obx(
                                        ()=>controller.coachingNotes['data'] == null?
                                    const Center(child: CupertinoActivityIndicator())
                                        :
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Card(
                                        elevation: 3,
                                        color: Colors.white,
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          color: Colors.transparent,
                                          alignment: Alignment.bottomRight,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: double.maxFinite,
                                                height: MediaQuery.of(context).size.height * 0.2,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                  controller.englishPressed == true
                                                      ? '${ApiService.IMAGE_URL+controller.coachingNotes['data'][index]['image']}'
                                                      : '${ApiService.IMAGE_URL+controller.coachingNotes['data'][index]['image']}',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '${controller.coachingNotes['data'][index]['title']}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            )

                        ],
                      ),
                    ):
                    Expanded(child: Center(child: Text(controller.coachingNotes['message']),)):
                    Expanded(
                      child: Center(
                        child:   CupertinoActivityIndicator(),
                      ),
                    )

                  ],
                ),
              ],
            ),
          );
        }

      }else{

        return  Scaffold(
          backgroundColor: Colors.blue.shade50,

          body: TabBarView(
            controller: controller.tabController,
            children: [
              Column(
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
                            childAspectRatio: 0.6),
                        itemCount: controller.bookList['data'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {


                              print("===============bookkkk=====ontap");


                              var data={
                                "notedetails": "false",
                                "bookid": controller.coachingNotes['data'][index]['id'].toString(),
                                "free": "false",
                                "category":"${controller.subjectName}, ${controller.coachingName} ${controller.examType}",
                                "bookName": controller.coachingNotes['data'][index]['title'].toString()??"",
                                "imageURL":  "${ApiService.IMAGE_URL+controller.coachingNotes['data'][index]['image']}"
                              };

                              Get.toNamed(Routes.SPECIFIC_BOOK_VIEW,parameters: data);

                              print("===============bookkkk=====ontap");

                              // Get.to(SubjectWiseView(
                              //   coachingName: '${widget.map['name'][widget.index]}',
                              //   examType:
                              //   '${dashboardController.examCategories.value}',
                              //   subjectName:
                              //   '${coursesNames['name'][index].toString()}',
                              // ));
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
                                                ? "${ApiService.IMAGE_URL+controller.bookList['data'][index]['image']}"
                                                : "${ApiService.IMAGE_URL+controller.bookList['data'][index]['image']}",
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
              /* Column(
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
                             color: englishPressed == true
                                 ? Colors.blue
                                 : Colors.black),
                       ),
                       Switch(
                           value: englishPressed == false ? true : false,
                           activeTrackColor: Colors.blue.shade200,
                           onChanged: (value) {
                             setState(() {
                               englishPressed = !englishPressed;
                             });
                           }),
                       Text(
                         "Hindi",
                         style: TextStyle(
                             fontSize: 14,
                             fontWeight: FontWeight.bold,
                             color: englishPressed == false
                                 ? Colors.blue
                                 : Colors.black),
                       )
                     ],
                   ),
                 ),
                 Expanded(
                   child: GridView.builder(
                       physics: const AlwaysScrollableScrollPhysics(),
                       primary: true,
                       scrollDirection: Axis.vertical,
                       gridDelegate:
                       const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisSpacing: 2,
                           crossAxisCount: 2,
                           childAspectRatio: 0.6),
                       itemCount: 5,
                       itemBuilder: (BuildContext context, int index) {
                         return InkWell(
                           onTap: () {
                             Get.to(
                                 SpecificBooksViews(
                                   notedetails:false,
                                   free: false,
                                   category:
                                   "${widget.subjectName}, ${widget
                                       .coachingName} ${widget.examType}",
                                   bookName:  bookList['data'][index]['book_name'],
                                   imageURL:  "https://ndn.manageprojects.in/${bookList['data'][index]['image']}", bookid: bookList['data'][index]['id'].toString(),
                                 ));

                           },
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Card(
                               elevation: 7,
                               color: Colors.white,
                               child: Container(
                                 padding: const EdgeInsets.only(right: 10),
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
                                       child:CachedNetworkImage(
                                         imageUrl:
                                         englishPressed == true
                                             ? "https://ndn.manageprojects.in/${bookList['data'][index]['image']}"
                                             : "https://ndn.manageprojects.in/${bookList['data'][index]['image']}",
                                         fit: BoxFit.fitHeight,
                                       ),
                                     ),
                                     const SizedBox(
                                       height: 5,
                                     ),
                                     Container(
                                         alignment: Alignment.center,
                                         child: Text(
                                           bookList['data'][index]['book_name'],
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
                         );
                       }),
                 )
               ],
             ),*/
            ],
          ),
        );
      }





     /*  controller.isHome=='true'
           ?
       controller.examType.isEmpty?
        Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.subjectName.value,
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                "${controller.coachingName}, ${controller.examType}",
                style: const TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ),
        body:  Column(

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
                        await  controller.callApi();

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
            controller.coachingNotes_isLoading==false?
            controller.coachingNotes['success']==true?

            Expanded(
              child: GridView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                primary: true,
                scrollDirection: Axis.vertical,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 2,
                    crossAxisCount: 2,
                    childAspectRatio: 0.6),
                children: [
                  for(int index=0;index< controller.coachingNotes['data'].length;index++)
                    if(controller.coachingNotes['data'][index]['exam_type'].toString()=='')(
                        InkWell(
                          onTap: () {
                            print("-----------------");


                            var data={
                              "notedetails": "true",
                              "bookid": controller.coachingNotes['data'][index]['id'].toString(),
                              "free": "false",
                              "category":"${controller.subjectName}, ${controller.coachingName} ${controller.examType}",
                              "bookName": controller.coachingNotes['data'][index]['title'].toString()??"",
                              "imageURL":  "https://ndn.manageprojects.in/${controller.coachingNotes['data'][index]['image']}"
                            };

                            Get.toNamed(Routes.SPECIFIC_BOOK_VIEW,parameters: data);

                          },
                          child: Obx(
                                ()=>controller.coachingNotes['data'] == null?
                            const Center(child: CupertinoActivityIndicator()):
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Card(
                                elevation: 3,
                                color: Colors.white,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.transparent,
                                  alignment: Alignment.bottomRight,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: double.maxFinite,
                                        height: MediaQuery.of(context).size.height * 0.2,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          controller.englishPressed == true
                                              ? 'https://ndn.manageprojects.in/${controller.coachingNotes['data'][index]['image']}'
                                              : 'https://ndn.manageprojects.in/${controller.coachingNotes['data'][index]['image']}',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${controller.coachingNotes['data'][index]['title']}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    )

                ],
              ),
            )
                :
            Expanded(child: Center(child: Text('Data not found'),)):
            Expanded(
              child: Center(
                child:   CupertinoActivityIndicator(),
              ),
            )

          ],
        ),
      ):
        Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.subjectName.value,
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                "${controller.coachingName}, ${controller.examType}",
                style: const TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),

          // overflow menu

          bottom: TabBar(
            controller: controller.tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorPadding: const EdgeInsets.symmetric(vertical: 8),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade400,
            tabs: [
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2,
                child: const Tab(text: "Pre"),
              ),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2,
                child: const Tab(text: "Mains"),
              ),
            ],
          ),
        ),
        body:  TabBarView(
          controller: controller.tabController,
          children: [
            Column(
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
                            await  controller.callApi();

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
                controller.coachingNotes_isLoading==false?
                controller.coachingNotes['success']!=false?
*//*
                 Expanded(
                   child: GridView(

                       shrinkWrap: true,
                       padding: EdgeInsets.zero,
                       physics: const AlwaysScrollableScrollPhysics(),
                       primary: true,
                       scrollDirection: Axis.vertical,
                       gridDelegate:
                       const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisSpacing: 2,
                           crossAxisCount: 2,
                           childAspectRatio: 0.6),
                       itemCount: coachingNotes['data'].length,
                       itemBuilder: (BuildContext context, int index) {
                         if(coachingNotes['data'][index]['exam_type'].toString()=='Pre'|| coachingNotes['data'][index]['exam_type'].toString()=='Pre ,Main'){
                           return InkWell(
                             onTap: () {
                               print("-----------------");
                               Get.to(
                                   SpecificBooksViews(
                                     notedetails:true,
                                     bookid: '${coachingNotes['data'][index]['id']}',
                                     free: false,
                                     category:
                                     "${widget.subjectName}, ${widget
                                         .coachingName} ${widget.examType}",
                                     bookName:  coachingNotes['data'][index]['title']??"",
                                     imageURL:  "https://ndn.manageprojects.in/${coachingNotes['data'][index]['image']}",
                                   ));
                               // Get.to(SubjectWiseView(
                               //   coachingName: '${widget.map['name'][widget.index]}',
                               //   examType:
                               //   '${dashboardController.examCategories.value}',
                               //   subjectName:
                               //   '${coursesNames['name'][index].toString()}',
                               // ));
                             },
                             child: Obx(
                                   ()=>coachingNotes['data'] == null?
                               const Center(child: CupertinoActivityIndicator()):
                               Padding(
                                 padding: const EdgeInsets.all(4.0),
                                 child: Card(
                                   elevation: 3,
                                   color: Colors.white,
                                   child: Container(
                                     padding: const EdgeInsets.all(10),
                                     color: Colors.transparent,
                                     alignment: Alignment.bottomRight,
                                     child: Column(
                                       mainAxisAlignment:
                                       MainAxisAlignment.center,
                                       crossAxisAlignment:
                                       CrossAxisAlignment.center,
                                       children: [
                                         SizedBox(
                                           width: double.maxFinite,
                                           height: MediaQuery.of(context).size.height * 0.2,
                                           child: CachedNetworkImage(
                                             imageUrl:
                                             englishPressed == true
                                                 ? 'https://ndn.manageprojects.in/${coachingNotes['data'][index]['image']}'
                                                 : 'https://ndn.manageprojects.in/${coachingNotes['data'][index]['image']}',
                                             fit: BoxFit.contain,
                                           ),
                                         ),
                                         const SizedBox(
                                           height: 5,
                                         ),
                                         Container(
                                             alignment: Alignment.center,
                                             child: Text(
                                               '${coachingNotes['data'][index]['title']}',
                                               textAlign: TextAlign.center,
                                               style: const TextStyle(
                                                   fontSize: 13,
                                                   fontWeight: FontWeight.w600),
                                             )),
                                       ],
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                           );
                         }
                         return SizedBox();
                       }),
                 )*//*
                Expanded(
                  child: GridView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    primary: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 2,
                        crossAxisCount: 2,
                        childAspectRatio: 0.6),
                    children: [
                      for(int index=0;index< controller.coachingNotes['data'].length;index++)
                        if(controller.coachingNotes['data'][index]['exam_type'].toString()=='Pre'|| controller.coachingNotes['data'][index]['exam_type'].toString()=='Pre, Main')(
                            InkWell(
                              onTap: () {
                                print("-----------------");

                                var data={
                                  "notedetails": "true",
                                  "bookid": controller.coachingNotes['data'][index]['id'].toString(),
                                  "free": "false",
                                  "category":"${controller.subjectName}, ${controller.coachingName} ${controller.examType}",
                                  "bookName": controller.coachingNotes['data'][index]['title'].toString()??"",
                                  "imageURL":  "https://ndn.manageprojects.in/${controller.coachingNotes['data'][index]['image']}"
                                };

                                Get.toNamed(Routes.SPECIFIC_BOOK_VIEW,parameters: data);

                              },
                              child: Obx(
                                    ()=>controller.coachingNotes['data'] == null?
                                const Center(child: CupertinoActivityIndicator()):
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Card(
                                    elevation: 3,
                                    color: Colors.white,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      color: Colors.transparent,
                                      alignment: Alignment.bottomRight,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: double.maxFinite,
                                            height: MediaQuery.of(context).size.height * 0.2,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                              controller.englishPressed == true
                                                  ? 'https://ndn.manageprojects.in/${controller.coachingNotes['data'][index]['image']}'
                                                  : 'https://ndn.manageprojects.in/${controller.coachingNotes['data'][index]['image']}',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${controller.coachingNotes['data'][index]['title']}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        )

                    ],
                  ),
                )
                    :
                Expanded(child: Center(child: Text(controller.coachingNotes['message']),)):
                Expanded(
                  child: Center(
                    child:   CupertinoActivityIndicator(),
                  ),
                )

              ],
            ),
            Column(
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
                            await  controller.callApi();

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
                controller.coachingNotes_isLoading==false?
                controller.coachingNotes['success']!=false?
                Expanded(
                  child: GridView(

                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    primary: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 2,
                        crossAxisCount: 2,
                        childAspectRatio: 0.6),
                    children: [
                      for(int index=0;index< controller.coachingNotes['data'].length;index++)
                        if(controller.coachingNotes['data'][index]['exam_type'].toString()=='Main'|| controller.coachingNotes['data'][index]['exam_type'].toString()=='Pre, Main')(
                            InkWell(
                              onTap: () {
                                print("-----------------");


                                var data={
                                  "notedetails": "true",
                                  "bookid": controller.coachingNotes['data'][index]['id'].toString(),
                                  "free": "false",
                                  "category":"${controller.subjectName}, ${controller.coachingName} ${controller.examType}",
                                  "bookName": controller.coachingNotes['data'][index]['title'].toString()??"",
                                  "imageURL":  "https://ndn.manageprojects.in/${controller.coachingNotes['data'][index]['image']}"
                                };

                                Get.toNamed(Routes.SPECIFIC_BOOK_VIEW,parameters: data);

                              },
                              child: Obx(
                                    ()=>controller.coachingNotes['data'] == null?
                                const Center(child: CupertinoActivityIndicator())
                                    :
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Card(
                                    elevation: 3,
                                    color: Colors.white,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      color: Colors.transparent,
                                      alignment: Alignment.bottomRight,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: double.maxFinite,
                                            height: MediaQuery.of(context).size.height * 0.2,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                              controller.englishPressed == true
                                                  ? 'https://ndn.manageprojects.in/${controller.coachingNotes['data'][index]['image']}'
                                                  : 'https://ndn.manageprojects.in/${controller.coachingNotes['data'][index]['image']}',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${controller.coachingNotes['data'][index]['title']}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        )

                    ],
                  ),
                ):
                Expanded(child: Center(child: Text(controller.coachingNotes['message']),)):
                Expanded(
                  child: Center(
                    child:   CupertinoActivityIndicator(),
                  ),
                )

              ],
            ),
          ],
        ),
      )
          :
       Scaffold(
        backgroundColor: Colors.blue.shade50,

        body: TabBarView(
          controller: controller.tabController,
          children: [
            Column(
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
                          childAspectRatio: 0.6),
                      itemCount: controller.bookList['data'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {


                            print("===============bookkkk=====ontap");


                            var data={
                              "notedetails": "false",
                              "bookid": controller.coachingNotes['data'][index]['id'].toString(),
                              "free": "false",
                              "category":"${controller.subjectName}, ${controller.coachingName} ${controller.examType}",
                              "bookName": controller.coachingNotes['data'][index]['title'].toString()??"",
                              "imageURL":  "https://ndn.manageprojects.in/${controller.coachingNotes['data'][index]['image']}"
                            };

                            Get.toNamed(Routes.SPECIFIC_BOOK_VIEW,parameters: data);

                            print("===============bookkkk=====ontap");

                            // Get.to(SubjectWiseView(
                            //   coachingName: '${widget.map['name'][widget.index]}',
                            //   examType:
                            //   '${dashboardController.examCategories.value}',
                            //   subjectName:
                            //   '${coursesNames['name'][index].toString()}',
                            // ));
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
                                              ? "https://ndn.manageprojects.in/${controller.bookList['data'][index]['image']}"
                                              : "https://ndn.manageprojects.in/${controller.bookList['data'][index]['image']}",
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
            *//* Column(
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
                             color: englishPressed == true
                                 ? Colors.blue
                                 : Colors.black),
                       ),
                       Switch(
                           value: englishPressed == false ? true : false,
                           activeTrackColor: Colors.blue.shade200,
                           onChanged: (value) {
                             setState(() {
                               englishPressed = !englishPressed;
                             });
                           }),
                       Text(
                         "Hindi",
                         style: TextStyle(
                             fontSize: 14,
                             fontWeight: FontWeight.bold,
                             color: englishPressed == false
                                 ? Colors.blue
                                 : Colors.black),
                       )
                     ],
                   ),
                 ),
                 Expanded(
                   child: GridView.builder(
                       physics: const AlwaysScrollableScrollPhysics(),
                       primary: true,
                       scrollDirection: Axis.vertical,
                       gridDelegate:
                       const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisSpacing: 2,
                           crossAxisCount: 2,
                           childAspectRatio: 0.6),
                       itemCount: 5,
                       itemBuilder: (BuildContext context, int index) {
                         return InkWell(
                           onTap: () {
                             Get.to(
                                 SpecificBooksViews(
                                   notedetails:false,
                                   free: false,
                                   category:
                                   "${widget.subjectName}, ${widget
                                       .coachingName} ${widget.examType}",
                                   bookName:  bookList['data'][index]['book_name'],
                                   imageURL:  "https://ndn.manageprojects.in/${bookList['data'][index]['image']}", bookid: bookList['data'][index]['id'].toString(),
                                 ));

                           },
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Card(
                               elevation: 7,
                               color: Colors.white,
                               child: Container(
                                 padding: const EdgeInsets.only(right: 10),
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
                                       child:CachedNetworkImage(
                                         imageUrl:
                                         englishPressed == true
                                             ? "https://ndn.manageprojects.in/${bookList['data'][index]['image']}"
                                             : "https://ndn.manageprojects.in/${bookList['data'][index]['image']}",
                                         fit: BoxFit.fitHeight,
                                       ),
                                     ),
                                     const SizedBox(
                                       height: 5,
                                     ),
                                     Container(
                                         alignment: Alignment.center,
                                         child: Text(
                                           bookList['data'][index]['book_name'],
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
                         );
                       }),
                 )
               ],
             ),*//*
          ],
        ),
      );*/
    });


  }
}
