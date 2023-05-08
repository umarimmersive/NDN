import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
class TabsLightController extends GetxController {


   


  RxMap examCoaching = {}.obs;


  @override
  void onInit() {
   // log("===============++++++++++++++++${id}");
    callApi();
    super.onInit();
  }

  callApi() async{
    http.Response response =await http.get(Uri.parse('https://ndn.manageprojects.in/api/coachingList'));
    print(response);
    print(response.body);
    examCoaching.value = jsonDecode(response.body);

    update();

  }


}