import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/constants/api_service.dart';
import 'package:national_digital_notes_new/utils/routes/app_pages.dart';
import 'package:national_digital_notes_new/views/dashboard_screen/controller_home_view.dart';
import 'package:national_digital_notes_new/views/detailed_coaching_screen/detailed_coaching_controller.dart';
import 'package:national_digital_notes_new/views/profile_settings_screen/profile_settings_views.dart';

import '../add_to_cart_screen/add_to_cart_view.dart';
import '../subject_books/subject_wise_view.dart';
import 'package:http/http.dart' as http;

class DetailedCoachingView extends GetView<detailed_coaching_controller> {

  //final controller = Get.find<detailed_coaching_controller>();
  final dashboardController = Get.find<controller_home_view>();

  @override
  Widget build(BuildContext context) {
   // log(dashboardController.examCategories.value);
    return Obx(
      () => DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.blue.shade50,
          appBar: AppBar(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 '${controller.cochingName}',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  dashboardController.examCategories.value,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Get.to(const AddToCartView());
                  },
                  icon: const Icon(Icons.shopping_cart))
              // overflow menu
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  height: 150,
                  viewportFraction: 0.99,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: controller.imagesURL1.map((img) {
                  print("==========image");
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width * 0.99,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: CachedNetworkImage(
                            imageUrl:
                            ApiService.IMAGE_URL+img['img'],
                            fit: BoxFit.fill,
                          )
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10,
              ),
             /* const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(
                  "SUBJECTS",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),*/
              const SizedBox(
                height: 10,
              ),


            // the tab bar with two items
            SizedBox(
              height: 50,
              child: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(
                    text: 'Subjects',
                    ),
                    Tab(
                      text: 'Online Test Series',
                    ),
                  ],
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  controller.isLoading==false?
                  controller.get_subject.length>0?

                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        primary: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 2,
                            crossAxisCount: 2,
                            childAspectRatio: 1.2),
                        itemCount: controller.get_subject.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {

                              var data = {
                                "isHome": "true",
                                "id": controller.cochingId.value,
                                "coachingName": controller.cochingName.value,
                                "examType":controller.get_subject[index]['exam_type'].toString(),
                                "subjectName": controller.get_subject[index]['subject_name'].toString(),
                                "subjectId":  controller.get_subject[index]['id'].toString(),
                              };

                              Get.toNamed(Routes.SUBJECT_WISE_VIEW,parameters: data);


                              // Get.to(SubjectWiseView(isHome:true, id: controller.coursesId.value, coachingName:
                              // /*get_subject[index]['subject_name'].toString()*/controller.cochingName.value,
                              // examType: controller.get_subject[index]['exam_type'],
                              // subjectName: '${controller.get_subject[index]['subject_name']}',
                              // subjectId: controller.get_subject[index]['id'].toString()));
                            },
                            child: Card(
                              elevation: 3,
                              color: Colors.white,
                              child: Container(
                                padding: const EdgeInsets.only(right: 10),
                                color: Colors.transparent,
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 80,
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 0),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          controller.get_subject[index]['subject_name'].toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    const Divider(
                                      thickness: 1.3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Subject',
                                            //controller.get_subject[index]['description'].toString().substring(0,10),
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(fontSize: 10),
                                          ),
                                        ),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              width: 35,
                                              height: 35,
                                              child: CachedNetworkImage(
                                                  imageUrl:ApiService.IMAGE_URL+controller.get_subject[index]['icon'])),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ) :

                  Center(
                    child: Text(
                      'No subject found',
                    ),
                  )

                      :
                  Center(child: CircularProgressIndicator()),

                  // second tab bar viiew widget
                  // first tab bar view widget
                  controller.isLoading1==false?
                  controller.exam_type_list.length>0?
                     Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                       child: ListView.builder(
                             itemCount: controller.exam_type_list.length,
                              itemBuilder: (BuildContext context, int index) {
                         return InkWell(
                               onTap: (){
                                 var data={
                                   "cochingId":controller.cochingId.toString(),
                                   "examId":controller.exam_id.toString(),
                                   "testId":controller.exam_type_list[index].id.toString(),
                                   "title":controller.exam_type_list[index].title.toString(),
                                   };
                                  Get.toNamed(Routes.TEST_LIST,parameters: data);
                                     },
                       child: Padding(
                                 padding: const EdgeInsets.only(top: 00.0,left: 5,right: 5,),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                    ),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
                                  child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                     Text(
                                       controller.exam_type_list[index].title,
                                        style: TextStyle(fontSize: 16.0),
    ),

    ],
    ),
    ),
    ),
    ),
    );
    },
    ),
                  )
                      :
                     Center(
                    child: Text(
                      'No Test series found',
                    ),
                  )

                      :
                  Center(child: CircularProgressIndicator()),
                ],
              ),
            ),


            ],
          )
        ),
      ),
    );
  }
}
