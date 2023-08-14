import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:national_digital_notes_new/utils/constants/api_service.dart';
import 'package:national_digital_notes_new/utils/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/constants/my_local_service.dart';
import '../../utils/global_widgets/globle_var.dart';
import '../../utils/global_widgets/google_login/authentication.dart';
import '../../utils/global_widgets/snackbar.dart';
import '../dashboard/views/dashboard_view.dart';
import '../dashboard_screen/Home_view.dart';

class SignupController extends GetxController {

  Map loginResponse ={}.obs;

  RxString loginType = 'app'.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confPassController = TextEditingController();

  var obscureNewPass = true.obs;
  var obscureConfPass = true.obs;

  RxBool agree = false.obs;


  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }


  Validation(type,id){
    if(nameController.text.isEmpty){
      snackbar("Please enter your name.");
    }else if(emailController.text.isEmpty){
      snackbar("Please enter your email.");
    }else if(mobileController.text.isEmpty){
      snackbar("Please enter your mobile number.");
    }else if(passController.text.isEmpty){
      snackbar("Please Enter At Least 6 Digit Password.");
    }else if(confPassController.text.isEmpty){
      snackbar("Please Enter At Least 6 Digit Password.");
    }else if(passController.text!=confPassController.text) {
      snackbar("Both Password Does Not Match");
    }else{
      if(agree.value){
        Signup(type,id);
      }else{
        snackbar("Please read and accept terms and conditions");
      }
    }
  }


  Signup(type,id) async {
    try {
      isLoading(true);
      var response = await ApiService()
          .SignUp(nameController.text,emailController.text,mobileController.text,passController.text,confPassController.text,type.toString(),id.toString());
      print({'========================$response'});

      if (response['success'] == true) {

        snackbar(response['message']);

        await my_local_service.updateSharedPreferencesFromServer(response['data']['id'].toString());
        await  my_local_service.updateSharedPreferences(response['data']);
        nameController.clear();
        emailController.clear();
        passController.clear();
        confPassController.clear();
        mobileController.clear();

        snackbar(response['message'].toString());



        if(userData!.phoneNumber.isEmpty&&userData!.phoneNumber=='null'){
          Get.offAndToNamed(Routes.ADD_MOBILE_NUMBER);
        }else{
          Get.offAndToNamed(Routes.DESHBOARD);
        }

        isLoading(false);

      } else if (response['success'] == false) {

        snackbar(response['message'].toString());

      }

    } finally {
      isLoading(false);


    }
  }

  void onGoogleLogin() async {
    // await _googleSignIn.disconnect();
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = await Authentication.signInWithGoogle(context: Get.context!);

    if (user != null) {
      print("LOGIN_IN");
      print(user.uid);
      print(user.email.toString());
      print(user.displayName.toString());
      emailController.text = user.email.toString();
      passController.text = "";
      //userID.value = user.uid;
      nameController.text = user.displayName.toString();
      Signup("google", user.uid);

    } else {
      print("LOGIN_out");
    }
  }




}