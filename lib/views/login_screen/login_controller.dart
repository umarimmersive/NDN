import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:national_digital_notes_new/utils/constants/my_local_service.dart';
import 'package:national_digital_notes_new/views/dashboard_screen/Home_view.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/constants/Globle_data.dart';
import '../../utils/constants/api_service.dart';
import '../../utils/global_widgets/snackbar.dart';
import '../dashboard/views/dashboard_view.dart';

class Login_controller extends GetxController{
  RxBool on = false.obs; // our observable

  RxString email = ''.obs;
  RxString pass = ''.obs;

  var obscureNewPass = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();



  @override
  void onInit() {

    super.onInit();
  }


  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }


  Validation(){
   if(emailController.text.isEmpty){
      snackbar("Please enter your email.");
    }else if(passController.text.isEmpty){
      snackbar("Please enter your password.");
    }else{
     getLogin();
    }
  }
  RxBool isLoading=false.obs;


   getLogin() async {
    try {
      isLoading(true);
      String? deviceId = await _getId();

      print('----------------------------$device_token');


      var response = await ApiService()
          .Login(emailController.text, passController.text,device_token.toString());
      print({'response==================================$response'});

        if (response['success'] == true) {
          snackbar(response['message']);


            await my_local_service.updateSharedPreferencesFromServer(response['data']['id'].toString());

            await my_local_service.updateSharedPreferences(response['data']);


          isLoading(false);

          emailController.clear();
          passController.clear();


          Get.to(DashboardView());

        } else if (response['success'] == false) {
          snackbar(response['message']);
          isLoading(false);
        }

    } finally {
      isLoading(false);


    }
  }

}