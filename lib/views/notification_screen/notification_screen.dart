import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/api_service.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {


  @override
  void initState() {
    callApi();
    // TODO: implement initState
    super.initState();
  }



  final isLoading=false.obs;
  final status=false.obs;
  final notification_list=[].obs;


  callApi() async{
    // bookList.clear();
    isLoading(true);

    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'notificationList'),body: {
      "user_id":userData!.userId
    });

    var data=jsonDecode(response.body);
    status.value=data['success'];

    log("=========$data");

    if (data['success'] == true) {

      print(response);
      print(response.body);
      notification_list.addAll(data['data']);
      print("notification_list==============$notification_list");
      setState(() {

      });
      isLoading(false);

      setState(() {

      });
      //update();
    } else if (data['success'] == false) {
      //book_detils.value = data;
      isLoading(false);
      setState(() {

      });
    }

  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Screen"),
      ),
      body: isLoading==true?Center(child: CupertinoActivityIndicator(),):
      notification_list.isEmpty?
          Center(child: Text('No data found'),):
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // for(int i=0;i< notification_list.length;i++)
          Expanded(
            child: Container(
              child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return  ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text(notification_list[index]['message']??''),
                  subtitle: Text(notification_list[index]['date_time']??''),
                  trailing: Text(notification_list[index]['time']??''),
                );
              }),
            ),
          ),
        

         /* const ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Delivered Book"),
            subtitle: Text("23-09-22"),
            trailing: Text("07:10 PM"),
          ),
          ListTile(
            tileColor: Colors.red.shade100,
            leading: const Icon(Icons.notifications),
            title: const Text("Update Account Password"),
            subtitle: const Text("23-09-22"),
            trailing: const Text("07:10 PM"),
          ),
          const ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Message from NDN"),
            subtitle: Text("23-09-22"),
            trailing: Text("07:10 PM"),
          ),*/
        ],
      ),
    );
  }
}
