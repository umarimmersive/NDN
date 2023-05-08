import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../../utils/constants/Globle_data.dart';

class controller_home_view extends GetxController {
  RxBool on = false.obs; // our observable
  RxMap examCategoriesMap = {}.obs;
  RxString examCategories = ''.obs;
  RxList mainSliderImg = [].obs;

  final is_Loading=false.obs;

  @override
  void onInit() async{
   // _selectedIndex=0;
    print("===================deshboard");
 //  await get_shardpref();
    callApi();
    mainSliderApi();
    Contect();
    super.onInit();
  }

  mainSliderApi() async{
    http.Response response =await http.post(Uri.parse('https://ndn.manageprojects.in/api/slider'),body: {
      "slider_type": "Main Slider"
    });

    print('response');
    print(response.body);
    var temp = jsonDecode(response.body);
    for(var i =0;i< temp['data'].length; i++){
      print(temp['data'][i]['img']);
      mainSliderImg.value.add(temp['data'][i]['img'].toString().removeAllWhitespace);

    }
   // await get_shardpref();
    update();

  }

  final Contectnumber="".obs;


  Contect() async{
    http.Response response =await http.get(Uri.parse('https://ndn.manageprojects.in/api/contactNumber'));

    print('response');
    print(response.body);
    var temp = jsonDecode(response.body);
    Context_number.value=temp['data']['contact_number'];
    print(" Contectnumber.value============${Contectnumber.value}");
    update();
  }







  callApi() async{
    http.Response response =await http.get(Uri.parse('https://ndn.manageprojects.in/api/examList'));
    print(response);
    print(response.body);
    var data=jsonDecode(response.body);
    if (data['success'] == true) {
      examCategoriesMap.value = jsonDecode(response.body);
      update();
    } else if (data['success'] == false) {

    }


    update();
  }


}