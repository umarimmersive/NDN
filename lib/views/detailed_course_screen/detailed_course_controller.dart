import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:national_digital_notes_new/utils/constants/toast.dart';

class detailed_course_controller extends GetxController with GetSingleTickerProviderStateMixin{

  @override
  void onInit() {
    id.value=Get.parameters['id'].toString();
    title.value=Get.parameters['title'].toString();

    print('id-----------------------------${id.value}');
    print('title-----------------------------${title.value}');

    book_List();
    Call_api();
    tabController = TabController(length: 5, vsync: this);
    scrollController = ScrollController();
    // TODO: implement onInit
    super.onInit();
  }


  final id=''.obs;
  final title=''.obs;
  TabController? tabController;
  ScrollController? scrollController;
  Map overviewMap = {} ;
  Map syllabusMap = {} ;
  Map examMap = {} ;
  RxMap coachingNotes = {}.obs;
  RxMap bookList = {}.obs;
  final isLoading=false.obs;
  final englishPressed=true.obs;
  final coachingNotes_isLoading=false.obs;


  final isLoder= false.obs;



  callOverview() async{
    isLoder(true);

    http.Response response = await http.post(Uri.parse('https://ndn.manageprojects.in/api/examOverview'),body: {
      "exam_id":id.value.toString()
    });
    var ConvertDataToJson = jsonDecode(response.body);

    if (ConvertDataToJson.containsKey('success')) {

      if(ConvertDataToJson['success']==true){
        overviewMap = jsonDecode(response.body);

        isLoder(false);
      }else{
        isLoder(false);
      }
    } else
      Toast.show("Something went wrong or No Connection !");
  }


  var ConvertDataToJson;


  callSyllabus() async{
    isLoder(true);


    http.Response response = await http.post(Uri.parse('https://ndn.manageprojects.in/api/examSyllabus'),body: {
      "exam_id": id.value.toString()
    });
    var ConvertDataToJson = jsonDecode(response.body);

    if (ConvertDataToJson.containsKey('success')) {

      if(ConvertDataToJson['success']==true){
        syllabusMap = jsonDecode(response.body);


        isLoder(false);

      }else{
        isLoder(false);
      }
    } else
      Toast.show("Something went wrong or No Connection !");
  }


  callExam() async{
    isLoder(true);


    http.Response response = await http.post(Uri.parse('https://ndn.manageprojects.in/api/examDates'),body: {
      "exam_id": id.value.toString()
    });
    ConvertDataToJson = jsonDecode(response.body);

    if (ConvertDataToJson.containsKey('success')) {

      if(ConvertDataToJson['success']==true){
        examMap = jsonDecode(response.body);


        isLoder(false);

      }else{
        isLoder(false);
      }
    } else
      Toast.show("Something went wrong or No Connection !");
  }



  book_List() async{
    bookList.clear();
    isLoading(true);
    print("englishPressed=========================+++++++++++++$englishPressed");
    print("book list=========================+++++++++++++${id.toString()}");
    http.Response response;

    if(englishPressed.isTrue){
      response = await http.post(Uri.parse('https://ndn.manageprojects.in/api/examBookList'),
          body: {
            "exam_id": id.value.toString(),
            "language":"English"
          });
    }else{
      response = await http.post(Uri.parse('https://ndn.manageprojects.in/api/examBookList'),body: {
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


  Call_api()async{
    await callOverview();
    await callSyllabus();
    await callExam();
  }


  @override
  void dispose() {
    scrollController!.dispose();
    tabController!.dispose();
    super.dispose();
  }

}