import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/constants/my_local_service.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';

import '../../../../utils/constants/api_service.dart';
import '../../../../utils/global_widgets/snackbar.dart';
import '../../../../views/dashboard/views/dashboard_view.dart';

class AddMobileNumberController extends GetxController {
  //TODO: Implement AddMobileNumberController
  RxBool on = false.obs; // our observable

  RxString email = ''.obs;
  RxString pass = ''.obs;

  var obscureNewPass = true.obs;
  TextEditingController emailController = TextEditingController();
  //TextEditingController passController = TextEditingController();



  @override
  void onInit() {

    super.onInit();
  }





  Validation(){
    if(emailController.text.isEmpty){
      snackbar("Please enter your mobile number.");
    }else{
      getLogin();
    }
  }
  RxBool isLoading=false.obs;


  getLogin() async {
    try {
      isLoading(true);
      print('--------------${emailController.text}');
      var response = await ApiService()
          .Add_phone_number(userData!.userId,emailController.text);


      if (response['success'] == true) {
        snackbar(response['message']);

        await my_local_service.updateSharedPreferencesFromServer(userData!.userId.toString());

        isLoading(false);

        emailController.clear();
        //passController.clear();

        Get.to(DashboardView());

      } else if (response['success'] == false) {
        snackbar(response['message']);
        isLoading(false);
      }

    } finally {
      isLoading(false);


    }
  }



  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
