
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../controllers/detailed_booklist.dart';
import '../../utils/global_widgets/snackbar.dart';

class subject_wise_view_controller extends GetxController with GetSingleTickerProviderStateMixin {

  TabController? tabController;
  ScrollController? _scrollController;


  final isHome=''.obs;
  final id=''.obs;
  final coachingName=''.obs;
  final examType=''.obs;
  final subjectName=''.obs;
  final subjectId=''.obs;


  DetailBookList detailBookList = Get.put(DetailBookList());


  final englishPressed = true.obs;

  @override
  void onInit() {



    // TODO: implement onInit
    super.onInit();
  }








  /*@override
  void initState() {
    log("is home=========================+++++++++++++${widget.isHome}");
    log("=========================+++++++++++++${widget.id}");
    print("==================${widget.id}");
    if(widget.isHome){
      callApi();
    }

    book_List();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }*/





  @override
  void dispose() {
    _scrollController!.dispose();
    tabController!.dispose();
    super.dispose();
  }




}