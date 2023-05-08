
import 'dart:convert' as convert;
import 'package:get/get.dart';
import 'package:national_digital_notes_new/models/user_modal.dart';
import 'package:national_digital_notes_new/utils/constants/api_service.dart';
import 'package:national_digital_notes_new/views/pre_login_screen/pre_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global_widgets/globle_var.dart';

class my_local_service{

  static UserModal updateSharedPreferences(Map userMap){
    String userDataString  = convert.jsonEncode(userMap);
    print('updating sharedpreference : $userDataString');
    sharedPreference.setString('userData', userDataString);
    userData = UserModal.fromJson(userMap);
    print('the userdata is ${userData}');
    return userData!;
  }


  static Future<UserModal> updateSharedPreferencesFromServer(String userId) async{
    sharedPreference = await SharedPreferences.getInstance();

    Map userMap = await ApiService().userProfile(userId);

   //Map userMap = await Webservices.getMap(ApiUrls.getUserDetails + '$userId'+'&viewer_id='+'$userId');
    print("userData============================$userMap");
    return updateSharedPreferences(userMap);
    // retur
  }


  static bool isLoggedIn(){
    if(sharedPreference.getString('userData')==null){
      print('the user login status is false');
      return false;
    }else{
      Map userMap = convert.jsonDecode(sharedPreference.getString('userData')!);
      updateSharedPreferences(userMap);
      print('the user login status is true');
      return true;
    }
  }

  static void logout(){
    sharedPreference!.clear();
    Get.offAll(PreLoginScreen());
    userData = null;
  }

}