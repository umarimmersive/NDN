import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:national_digital_notes_new/utils/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/constants/api_service.dart';
import 'detailed_order_details_view.dart';
import 'package:http/http.dart' as http;
class MyLibraryView extends StatefulWidget {
  const MyLibraryView({Key? key}) : super(key: key);

  @override
  State<MyLibraryView> createState() => _MyLibraryViewState();
}

class _MyLibraryViewState extends State<MyLibraryView> {


  @override
  void initState() {
    print("pi=========================");
    callApi();
    // TODO: implement initState
    super.initState();
  }

  final isLoading=false.obs;
  final status=false.obs;
  final library_list=[];
  callApi() async{
    // bookList.clear();
    isLoading(true);

    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'myLibrary'),body: {
      "user_id":userData!.userId.toString(),
    });

    var data=jsonDecode(response.body);
    status.value=data['success'];

    log("=========$data");

    if (data['success'] == true) {

      print(response);
      print(response.body);
      library_list.addAll(data['data']);
      print("88888*******");
      print("==============$library_list");
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
        leading: IconButton(
          onPressed: () {
            Get.toNamed(Routes.DESHBOARD,parameters: {"index":"0"});
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text("My Library"),
      ),
      body:

        Obx((){
    if(isLoading==true){
    return Center(child: CupertinoActivityIndicator());
    }else{
    if(status.value==true){
    return  ListView.builder(
      itemCount: library_list.length,
      itemBuilder: (BuildContext context, int i) {
      return Card(
        child: ListTile(
        onTap: () {

          Get.to(
         DetailedBooksOrder(
          bookid: library_list[i]['id'].toString(),
          ));
    },
          leading: CachedNetworkImage(
          imageUrl:
        ApiService.IMAGE_URL+library_list[i]['image'].toString(),
    ),
        title:  Text(library_list[i]['title']),
        subtitle:  Text("Delivered on "+library_list[i]['purchase_on']),
        trailing: const Icon(Icons.chevron_right),
        ),
      );
      });
    } else{
    return Center(child: Text("Record Not Found."));
    }
    }
       }


    ));
  }
}
