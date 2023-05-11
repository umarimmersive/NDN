
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/constants/api_service.dart';
import '../../utils/global_widgets/snackbar.dart';

class specific_book_details_controller extends GetxController{


  final bookid=''.obs;
  final bookName=''.obs;
  final imageURL=''.obs;
  final category=''.obs;
  final free=''.obs;
  final notedetails=''.obs;


/*
  var data={
    "notedetails": "true",
    "bookid": coachingNotes['data'][index]['id'].toString(),
    "free": "false",
    "category":"${widget.subjectName}, ${widget.coachingName} ${widget.examType}",
    "bookName": coachingNotes['data'][index]['title'].toString()??"",
    "imageURL":  "https://ndn.manageprojects.in/${coachingNotes['data'][index]['image']}"
  };*/






  @override
  void onInit() {

    bookid.value=Get.parameters['bookid'].toString();
    bookName.value=Get.parameters['bookName'].toString();
    imageURL.value=Get.parameters['imageURL'].toString();
    category.value=Get.parameters['category'].toString();
    free.value= Get.parameters['free'].toString();
    notedetails.value=Get.parameters['notedetails'].toString();


    print('----------------------------------$bookid');
    print('----------------------------------$bookName');
    print('----------------------------------$imageURL');
    print('----------------------------------$category');
    print('----------------------------------$free');
    print('----------------------------------$notedetails');

    //print('----------------------------------$bookid');


    if(notedetails.value=='true'){
      print("notedetails========+============");
      noteDetails();
    }else{
      callApi();

      print('------------------------------book details');

      //print("simple================${book_detils[0]['simple_epub']}");
    }
    // TODO: implement onInit
    super.onInit();
  }


  final isFaved = false.obs;
  final addToCart = false.obs;






  final loading = false.obs;
  Dio dio = Dio();
  final filePath = "".obs;




  download(book_path) async {
    if (Platform.isAndroid || Platform.isIOS) {
      print("===============downloadFile");
      print("===============${book_path}");
      await downloadFile(book_path);
    } else {
      loading(false);
    }
  }

  Future downloadFile(book_path) async {
    if (await Permission.storage.isGranted) {
      print("===============ssss");
      await Permission.storage.request();
      await startDownload(book_path);
    } else {
      await startDownload(book_path);
    }
  }


  startDownload(book_path) async {
    print("==================dawnload");
    Directory? appDocDir = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();


    String path = appDocDir!.path + '/chair.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        ApiService.IMAGE_URL+book_path,
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          print((receivedBytes / totalBytes * 100).toStringAsFixed(0));


          loading(true);

        },
      ).whenComplete(() {

          loading(false);
          filePath.value = path;

      });
    } else {
        loading(false);
        filePath.value = path;

        print("filePath======================${filePath}");

    }
  }






  var book_detils=[].obs;

  final isLoading=false.obs;
  final wishlist_isLoading=false.obs;
  final Add_to_cart_isLoading=false.obs;
  final status=false.obs;
  var data;

  callApi() async{
    print('bookid====================${bookid.value.toString()}');
    book_detils.clear();
    isLoading(true);



    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'bookDetails'),body: {
      "book_id":bookid.value.toString(),
      "user_id": userData!.userId,
    });



    data=jsonDecode(response.body);
   // print("favv==================${data['data'][0]['is_fav']}");

    status.value=data['success'];

    print("dataaaa=======================$data");

    if (data['success'] == true) {

      print(response);
      print(response.body);
      book_detils.addAll(data['data']);
      //book_detils.value = data['data'];
      print("88888*******");
      print("==============$book_detils");

      await download(book_detils[0]['sample_epub'].toString());




      isLoading(false);
      //update();
    } else if (data['success'] == false) {
      //book_detils.value = data;
      isLoading(false);


    }

  }

  noteDetails() async{
    book_detils.clear();
    print('bookid====================${bookid.value.toString()}');
    // bookList.clear();
    isLoading(true);




    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'noteDetails'),body: {
      "note_id": bookid.value.toString(),
      "user_id": userData!.userId,
    });

    data=jsonDecode(response.body);
    status.value=data['success'];

    log("=========$data");

    if (data['success'] == true) {




      print(response);
      print(response.body);
      book_detils.addAll(data['data']);
      //book_detils.value = data['data'];
      print("88888*******");
      print("is_cart====================xasxcascas=======${book_detils[0]['is_cart']}");
      print("====================xasxcascas=======${book_detils[0]['sample_note']}");


      isLoading(false);

      //update();
    } else if (data['success'] == false) {
      //book_detils.value = data;
      isLoading(false);

    }

  }


  Add_fev() async{
    // bookList.clear();
    wishlist_isLoading(true);


   // print("user_id============================${user_id}");
    print("user_id============================${bookid.value.toString()}");
    print("book_detils[0]['book_type']============================${book_detils[0]['book_type']}");
    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'addFavorite'),body: {
      //"book_id":widget.bookid
      "user_id": userData!.userId,
      "item_id": bookid.value.toString(),
      "item_type":notedetails.value=='true'?"2":"1",
    });
    var data=jsonDecode(response.body);
    status.value=data['success'];

    snackbar(data['message']);

    log("data===============================$data");

    if (data['success'] == true) {


      wishlist_isLoading(false);

      //update();
    } else if (data['success'] == false) {
      //book_detils.value = data;
      wishlist_isLoading(false);


    }

  }

  Remove_wishlist() async{
    // bookList.clear();
    wishlist_isLoading(true);




    //print("user_id============================${user_id}");
    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'removeFavorite'),body: {
      //"book_id":widget.bookid
      "user_id": userData!.userId,
      "item_id": bookid.value.toString(),
      "item_type": notedetails.value=='true'?"2":"1",
    });



    var data=jsonDecode(response.body);
    status.value=data['success'];

    log("=========$data");

    if (data['success'] == true) {
      snackbar(data['message']);

      wishlist_isLoading(false);


      //update();
    } else if (data['success'] == false) {
      //book_detils.value = data;
      wishlist_isLoading(false);


    }

  }


  Add_to_cart(Price) async{

    // bookList.clear();
    Add_to_cart_isLoading(true);



    print("=======================${bookid.value.toString()}");
    print("=======================${notedetails.toString()}");
    print("=======================${Price}");
    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'addToCart'),body: {
      //"book_id":widget.bookid
      "user_id":userData!.userId,
      "item_id": bookid.value.toString(),
      "item_type":notedetails.value=='true'?"2":"1",
      "item_price":Price.toString(),
    });

    var data=jsonDecode(response.body);
    status.value=data['success'];

    snackbar(data['message']);

    print("addtocart===============================$data");

    if (data['success'] == true) {


      Add_to_cart_isLoading(false);

      //update();
    } else if (data['success'] == false) {
      //book_detils.value = data;
      Add_to_cart_isLoading(false);


    }

  }


  removeToCart() async{
    // bookList.clear();
    Add_to_cart_isLoading(true);




    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'removeToCart'),body: {
      "user_id": userData!.userId,
      "item_id": bookid.value.toString(),
      "item_type":notedetails.value=='true'?"2":"1",
    });

    var data=jsonDecode(response.body);
    status.value=data['success'];

    snackbar(data['message']);

    print("data===============================$data");

    if (data['success'] == true) {

      Add_to_cart_isLoading(false);


      //update();
    } else if (data['success'] == false) {
      //book_detils.value = data;
      Add_to_cart_isLoading(false);


    }

  }








}