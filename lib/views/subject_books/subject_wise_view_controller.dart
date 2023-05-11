
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
import '../../utils/constants/api_service.dart';
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

    isHome.value=Get.parameters['isHome'].toString();
    id.value=Get.parameters['id'].toString();
    coachingName.value=Get.parameters['coachingName'].toString();
    examType.value=Get.parameters['examType'].toString();
    subjectName.value=Get.parameters['subjectName'].toString();
    subjectId.value=Get.parameters['subjectId'].toString();

    tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();

    if(isHome.value=='true'){
      callApi();
    }else{
      book_List();
    }

    // TODO: implement onInit
    super.onInit();
  }




  RxMap coachingNotes = {}.obs;
  RxMap bookList = {}.obs;
  final isLoading=false.obs;
  final coachingNotes_isLoading=false.obs;

  callApi() async{
    coachingNotes.clear();
    coachingNotes_isLoading(true);
    print("widget.id=========================+++++++++++++${id.toString()}");
    print("widget.subjectId=========================+++++++++++++${subjectId.toString()}");
    print("=========================+++++++++++++$englishPressed");
    http.Response response;
    if(englishPressed.isTrue){
      response = await http.post(Uri.parse(ApiService.BASE_URL+'coachingNotes'),body: {
        "coaching_id":id.value.toString(),
        "subject_id": subjectId.value.toString(),
        "language":"English"
      });
    }else{
      response = await http.post(Uri.parse(ApiService.BASE_URL+'coachingNotes'),body: {
        "coaching_id":id.value.toString(),
        "subject_id":subjectId.value.toString(),
        "language":"Hindi"
      });
    }


    var data=jsonDecode(response.body);

    if (data['success'] == true) {

      print(response);
      print(response.body);
      coachingNotes.value = data;
      print("88888*******");
      print(coachingNotes['data'][0]['title']);
      print('==========+++++++++______________${coachingNotes.value}');



      coachingNotes_isLoading(false);
      //update();
    } else if (data['success'] == false) {
      coachingNotes.value = data;
      coachingNotes_isLoading(false);

    }
  }

  book_List() async{
    bookList.clear();
    isLoading(true);
    print("englishPressed=========================+++++++++++++$englishPressed");
    print("book list=========================+++++++++++++${id.toString()}");
    http.Response response;

    if(englishPressed.isTrue){
      response = await http.post(Uri.parse(ApiService.BASE_URL+'examBookList'),
          body: {
            "exam_id":id.value.toString(),
            "language":"English"
          });
    }else{
      response = await http.post(Uri.parse(ApiService.BASE_URL+'examBookList'),body: {
        "exam_id":id.value.toString(),
        "language":"Hindi"
      });
    }


    var data=jsonDecode(response.body);

    if (data['success'] == true) {

      print(response);
      print(response.body);
      bookList.value = data;
      print("88888*******");
      print(bookList['data'][0]['title']);
      print('==========+++++++++______________${bookList.value}');




      isLoading(false);
      //update();
    } else if (data['success'] == false) {
      bookList.value = data;
      isLoading(false);

    }
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