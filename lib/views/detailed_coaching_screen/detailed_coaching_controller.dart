import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../../utils/constants/Globle_data.dart';
import '../../utils/constants/api_service.dart';

class detailed_coaching_controller extends GetxController with GetSingleTickerProviderStateMixin{

  final is_Loading=false.obs;
  final coursesId=''.obs;
  final cochingName=''.obs;

  late TabController tabController;
  final selectedTabIndex = 0.obs;
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    coursesId.value=Get.parameters['coursesId'].toString();
    cochingName.value=Get.parameters['cochingName'].toString();

    print('--------$coursesId');
    print('--------$cochingName');

    print('details -----------------------------------call details');

    //print("=========================cochingName=========================${widget.cochingName}");
    callSubjectAPI();
    Get_coching_benner();
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
      var response = await ApiService().get_subject(int.parse(coursesId.value));
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
          .get_coching_benner(int.parse(coursesId.value));
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


  // controller_home_view dashboardController = Get.find();






}