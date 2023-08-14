import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global_widgets/globle_var.dart';

class ApiService {
 static late final BuildContext context;

  //static final String BASE_URL = "https://ndn.manageprojects.in/api/";
  static final String BASE_URL = "https://ndn.nationaldigitalnotes.com/api/";
  static final String IMAGE_URL = "https://ndn.nationaldigitalnotes.com/";

  static final String FAQ = "faq";
  static final String LOGIN = "login";
  static final String phoneUpdate = "phoneUpdate";
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
  static final String checkOutAllOrder = BASE_URL+"checkOutAllOrder";
  static final String get_profile = BASE_URL+"getProfile";
  static final String reviewSubmit = "reviewSubmit";
  static final String testList = "testList";
  static final String testSeriesList = "testSeriesList";
  static final String questionList = "questionList";
  static final String test_payment = "https://sandbox.cashfree.com/pg/orders";
  static final String TestSubmit = "testSubmit";
  static final String REPORT_OPTION = "coachingReportOptions";
  static final String REPORT = "testQuestionReport";
  static final String TEST_RESULT_LIST = "testResultList";
  static final String checkOutAllOnlineTest = "checkOutAllOnlineTest";


  static final String x_client_id = "2871162505f719d22dbc83aa6a611782";
  static final String x_client_secret = "TESTe579d9f7413748834968c1fa4e7defe50b82d316";


 Future Test_Submit({questions_one, Token,total_time,right_marks,negative_marks,series_id}) async {


   String jsonUser = jsonEncode(questions_one);
   print('---------------------------${jsonUser}');

   print('Data---------------------------${questions_one}');
   print('Token---------------------------$Token');
   print('total_time---------------------------$total_time');
   print('right_marks---------------------------$right_marks');
   print('negative_marks---------------------------$negative_marks');

   var data1= {
     "token": Token.toString(),
     "series_id": series_id.toString(),
     "questions": jsonEncode(questions_one),
     "total_time": total_time,
     "right_marks": right_marks.toString(),
     "negative_marks": negative_marks.toString().isEmpty?'0':negative_marks.toString(),
   };

   final response = await http.post(
       Uri.parse(BASE_URL + TestSubmit),
       headers: {HttpHeaders.acceptHeader: "application/json"},
       body: data1
   );
   var ConvertDataToJson = jsonDecode(response.body);
   return ConvertDataToJson;
 }

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
  Future ReviewSubmit({user_id, order_id, rating,rating_text}) async {
    final response = await http.post(
          Uri.parse(BASE_URL + reviewSubmit),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: ({
              'user_id': user_id.toString(),
              'order_id':order_id.toString(),
              'rating':rating.toString(),
              'rating_text':rating_text.toString(),
          })
      );
      var ConvertDataToJson = jsonDecode(response.body);
      return ConvertDataToJson;

  }

  Future Add_phone_number(user_id,phone) async {
    final response = await http.post(
          Uri.parse(BASE_URL + phoneUpdate),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: ({
              'user_id': user_id,
               'phone':phone.toString(),
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
  Future Test_Result_List(id,seriesID) async {
   print('seriesID-----------------------${seriesID}');
    final response = await http.post(
          Uri.parse(BASE_URL + TEST_RESULT_LIST),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: ({
              'token': id.toString(),
              'series_id': seriesID.toString(),
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


  Future Report_option(coaching_id) async {

   print('coaching_id------------------$coaching_id');

    final response = await http.post(
          Uri.parse(BASE_URL + REPORT_OPTION),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: ({
            "coaching_id":coaching_id,
          })
      );
      var ConvertDataToJson = jsonDecode(response.body);
      return ConvertDataToJson;
  }


  Future Report_send({coaching_id,user_id,question_id,report_option_id,explanation}) async {

   print('coaching_id------------------$coaching_id');
   print('user_id------------------$user_id');
   print('question_id------------------$question_id');
   print('report_option_id------------------$report_option_id');
   print('explanation------------------$explanation');

    final response = await http.post(
          Uri.parse(BASE_URL + REPORT),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: ({
            "coaching_id":coaching_id.toString(),
            "user_id":user_id.toString(),
            "question_id":question_id.toString(),
            "report_option_id":report_option_id.toString(),
            "explanation":explanation.toString(),
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
  Future get_Questions_list({user_Id,series_id}) async {
    print("=============${user_Id}");
    print("series_id----------${series_id}");
    final response = await http.post(
          Uri.parse(BASE_URL + questionList),
        headers: {HttpHeaders.acceptHeader: "application/json"},
        body: ({
          "token":user_Id.toString(),
          "series_id":series_id.toString(),
        })
      );
      var ConvertDataToJson = jsonDecode(response.body);
      return ConvertDataToJson;
  }


  Future get_test_list({id, exam_id,coaching_id}) async {
    final response = await http.post(
          Uri.parse(BASE_URL + testList),
        headers: {HttpHeaders.acceptHeader: "application/json"},
        body: ({
          "token":id.toString(),
          "exam_id":exam_id.toString(),
          "coaching_id":coaching_id.toString(),
        })
      );

      var ConvertDataToJson = jsonDecode(response.body);
      return ConvertDataToJson;
  }


  Future gettestSeriesList({id, test_id,coaching_id}) async {

    final response = await http.post(
          Uri.parse(BASE_URL + testSeriesList),
        headers: {HttpHeaders.acceptHeader: "application/json"},
        body: ({
          "token":id.toString(),
          "user_id":userData!.userId.toString(),
          "test_id":test_id.toString(),
          "coaching_id":coaching_id.toString(),
        })
      );
      var ConvertDataToJson = jsonDecode(response.body);
      return ConvertDataToJson;
  }

  Future Buy_course({transaction_id, payment_status,series_id}) async {

    final response = await http.post(
          Uri.parse(BASE_URL + checkOutAllOnlineTest),
        headers: {HttpHeaders.acceptHeader: "application/json"},
        body: ({
          "user_id":userData!.userId.toString(),
          "transaction_id":transaction_id.toString(),
          "payment_status":payment_status.toString(),
          "payment_method":'online'.toString(),
          "series_id":series_id.toString(),
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
