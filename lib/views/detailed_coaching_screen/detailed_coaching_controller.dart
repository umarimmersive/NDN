import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../models/getExamList.dart';
import '../../utils/constants/Globle_data.dart';
import '../../utils/constants/api_service.dart';

class detailed_coaching_controller extends GetxController with GetSingleTickerProviderStateMixin{

  final is_Loading=false.obs;
  final cochingName=''.obs;
  final cochingId=''.obs;
  final exam_id=''.obs;
  final exam_title=''.obs;

  late TabController tabController;
  final selectedTabIndex = 0.obs;


  final List<String> examTestSeriesData = [
    'Test Series 1',
    'Test Series 2',
    'Test Series 3',
    'Test Series 4',
    'Test Series 5',
  ];
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    exam_id.value=Get.parameters['exam_id'].toString();
    cochingId.value=Get.parameters['cochingId'].toString();
    cochingName.value=Get.parameters['cochingName'].toString();
    exam_title.value=Get.parameters['exam_title'].toString();


  /*  var data= {
      "exam_id": widget.id.toString(),
      "cochingId":"${Coching_list[index]['id'].toString()}",
      "cochingName":"${Coching_list[index]['coaching_name'].toString()}",
    };*/

    print('--------$cochingName');
    print('cochingId--------$cochingId');

    print('details -----------------------------------call details');

    //print("=========================cochingName=========================${widget.cochingName}");
    callSubjectAPI();
    Get_coching_benner();
    Get_exam_type_list();
    super.onInit();
  }

  final isLoading=false.obs;

  final get_subject=[].obs;
  List imagesURL=[];

  callSubjectAPI() async {
    //print("======================${widget.coursesId}");
    try {
      get_subject.clear();
      imagesURL.clear();
      isLoading(true);
      var response = await ApiService().get_subject(int.parse(cochingId.value));
      print({'$response'});

      if (response['success'] == true) {
        // About_us=response['data'];
        get_subject.addAll(response['data']);
        print("get_subject=======================${get_subject}");

        for(int i=0;i<response['data'].length;i++){
          imagesURL.add(response['data'][i]['icon']);
        }
        print("========$imagesURL");
        isLoading(false);
      } else if (response['success'] == false) {

      }

    } finally {
      isLoading(false);


    }
  }






  List imagesURL1 = [].obs;

  Get_coching_benner() async {

    //print("=============================+${widget.coursesId}");
    try {

      imagesURL1.clear();
      isLoading(true);

      var response = await ApiService()
          .get_coching_benner(int.parse(cochingId.value));
      print({'$response'});

      if (response['success'] == true) {
        // About_us=response['data'];
        imagesURL1.addAll(response['data']);

        print("slidderrrr========$imagesURL1");
        isLoading(false);
      } else if (response['success'] == false) {

        print("slidderrrr========$imagesURL1");
      }

    } finally {
      isLoading(false);


    }
  }


  Map coursesNames = {
  };



  final isLoading1=false.obs;
  final exam_type_list  = <getExamList>[].obs;


  Future Get_exam_type_list() async {
    try {
      isLoading1(true);
      var response = await ApiService().get_test_list(exam_id: exam_id.value,id: userData!.userId,coaching_id: cochingId);
      print({'get exam list----------------------------$response'});
      if (response['success'] == true) {

        List dataList = response['data'].toList();
         exam_type_list.value = dataList.map((json) => getExamList.fromJson(json)).toList();


      } else if (response['success'] == false) {
        isLoading1(false);
      }
    } finally {
      isLoading1(false);

    }
  }





}