import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
 static late final BuildContext context;

  static final String BASE_URL = "https://ndn.manageprojects.in/api/";

  static final String FAQ = "faq";
  static final String LOGIN = "login";
  static final String signup = "register";
  static final String forgotpassword = "forgotpassword";
  static final String about_us = "about_us";
  static final String subject = "subject";
  static final String get_news = "news";
  static final String coachingSlider = "coachingSlider";
  static final String setPassword = "setPassword";
  static final String newsCategoryList = "newsCategoryList";
  static final String quiz = "quiz";
  static final String orderDetails = BASE_URL+"orderDetails";
  static final String get_profile = BASE_URL+"getProfile";
  static final String test_payment = "https://sandbox.cashfree.com/pg/orders";



  static final String x_client_id = "2871162505f719d22dbc83aa6a611782";
  static final String x_client_secret = "TESTe579d9f7413748834968c1fa4e7defe50b82d316";



 // 'x-client-id':'2871162505f719d22dbc83aa6a611782',
 // 'x-client-secret':'89541fcf462c9df0d0d97e147beaa3270db3720b',




  // Future Faq() async {
  //   final response = await http.get(
  //     Uri.parse(BASE_URL + FAQ),
  //     headers: {HttpHeaders.acceptHeader: "application/json"},
  //   );
  //   var ConvertDataToJson = jsonDecode(response.body);
  //   return ConvertDataToJson;
  // }

  Future Login(email,password,id) async {
    final response = await http.post(
          Uri.parse(BASE_URL + LOGIN),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: ({
              'device_id': id,
               'login_type':'app',
              'email':email,
              'password': password,
          })
      );
      var ConvertDataToJson = jsonDecode(response.body);
      return ConvertDataToJson;

  }

  Future userProfile(id) async {
    final response = await http.post(
          Uri.parse(BASE_URL + get_profile),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: jsonEncode({
              'user_id': id.toString(),
          })
      );
      var ConvertDataToJson = jsonDecode(response.body);

      print('getprofile------------------------------------$ConvertDataToJson');
      return ConvertDataToJson;
  }

  Future SignUp(name,email,mobile,password,cpass,loginType,id) async {
    final response = await http.post(
          Uri.parse(BASE_URL + signup),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: ({
            "name":name,
            "email":email,
            "phone":mobile,
            "password":password,
            "re_password":cpass,
            "login_type":loginType,
            "id": id,
            'device_id': id,
          })
      );
      var ConvertDataToJson = jsonDecode(response.body);
      return ConvertDataToJson;
  }


//  ""user_id"":"""",
//         ""password"":"""",
//  ""re_password"":""""
// }"
 Future Set_new_pass(userid,new_pass,confirmpass) async {

    print("===============$new_pass");
    print("===============$confirmpass");
   final response = await http.post(
       Uri.parse(BASE_URL + setPassword),
       headers: {HttpHeaders.acceptHeader: "application/json"},
       body: ({
         "user_id":userid.toString(),
         "password":new_pass.toString(),
         "re_password":confirmpass.toString(),
       })
   );
   var ConvertDataToJson = jsonDecode(response.body);
   return ConvertDataToJson;
 }






  Future forgot_password(email) async {
    final response = await http.post(
          Uri.parse(BASE_URL + forgotpassword),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: ({
            "email":email,
          })
      );
      var ConvertDataToJson = jsonDecode(response.body);
      return ConvertDataToJson;
  }

  Future About_us() async {
    final response = await http.get(
          Uri.parse(BASE_URL + about_us),
      );
      var ConvertDataToJson = jsonDecode(response.body);
      return ConvertDataToJson;
  }

  Future get_subject(id) async {
    print("=============${id}");
    final response = await http.post(
          Uri.parse(BASE_URL + subject),
        headers: {HttpHeaders.acceptHeader: "application/json"},
        body: ({
          "coaching_id":id.toString(),
        })
      );
      var ConvertDataToJson = jsonDecode(response.body);
      return ConvertDataToJson;
  }
  Future get_coching_benner(id) async {
    print("=============${id}");
    final response = await http.post(
          Uri.parse(BASE_URL + coachingSlider),
        headers: {HttpHeaders.acceptHeader: "application/json"},
        body: ({
          "coaching_id":id.toString(),
        })
      );
      var ConvertDataToJson = jsonDecode(response.body);
      return ConvertDataToJson;
  }

 Future Get_news(news_date,language,category) async {
   final response = await http.post(
       Uri.parse(BASE_URL + get_news),
       headers: {HttpHeaders.acceptHeader: "application/json"},
       body: ({
         "news_date":news_date,
         "language":language.toString(),
         "category_id":category.toString(),
       })
   );
   var ConvertDataToJson = jsonDecode(response.body);
   return ConvertDataToJson;
 }

 Future Get_quiz(news_date,language) async {
   final response = await http.post(
       Uri.parse(BASE_URL + quiz),
       headers: {HttpHeaders.acceptHeader: "application/json"},
       body: ({
         "quiz_date":news_date.toString(),
         "language":language.toString(),
       })
   );
   var ConvertDataToJson = jsonDecode(response.body);
   return ConvertDataToJson;
 }
 Future Payment_getway(
     {orderId,
      orderAmount,
      orderCurrency,
       customer_id,
      customer_name,
      customer_email,
      customer_phone,
      order_note,
      today_date}) async {


    print("orderId===========================$orderId");
    print("===========================$orderAmount");
    print("===========================$orderCurrency");
    print("===========================$customer_id");
    print("===========================$customer_name");
    print("===========================$customer_email");
    print("===========================$customer_phone");
    print("===========================$order_note");
    print("today_date===========================$today_date");


   // print('postdata=----------------------$postdata');

   final response = await http.post(
       Uri.parse('https://sandbox.cashfree.com/pg/orders'),
       headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          //HttpHeaders.acceptHeader: "application/json",
         'x-client-id': "2871162505f719d22dbc83aa6a611782",
         'x-client-secret': "TESTe579d9f7413748834968c1fa4e7defe50b82d316",
         'x-api-version': '2022-09-01',
         'x-request-id': 'developer_name',
       },
       body: jsonEncode({
         "order_id": orderId.toString(),
         "order_amount": 100.00,
         "order_currency":orderCurrency.toString(),
         "customer_details": {
           "customer_id": customer_id.toString(),
           "customer_name": customer_name.toString(),
           "customer_email": customer_email.toString(),
           "customer_phone": customer_phone.toString()
         },
         "order_meta": {
           "notify_url": "https://test.cashfree.com"
         },
         "order_note": "some order note here",
       })
   );
   print('orderr==========json=========');

   var ConvertDataToJson = jsonDecode(response.body);
   return ConvertDataToJson;
 }

 Future Get_category() async {
   final response = await http.get(
       Uri.parse(BASE_URL + newsCategoryList),
       headers: {HttpHeaders.acceptHeader: "application/json"},
   );
   var ConvertDataToJson = jsonDecode(response.body);
   return ConvertDataToJson;
 }

}
