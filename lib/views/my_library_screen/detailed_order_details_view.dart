import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import 'package:dio/dio.dart';
import '../../utils/constants/api_service.dart';
import '../../utils/global_widgets/snackbar.dart';
import '../../utils/routes/app_pages.dart';
// ignore: must_be_immutable
class DetailedBooksOrder extends StatefulWidget {

  String bookid;


  DetailedBooksOrder(
      {super.key,
        required this.bookid,
      });

  @override
  State<DetailedBooksOrder> createState() => _DetailedBooksOrderState();
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class _DetailedBooksOrderState extends State<DetailedBooksOrder> {



  @override
  void initState() {

    book_details();
    // TODO: implement initState
    super.initState();
  }

  final isLoading=false.obs;
  final filePath =''.obs;
  final status=false.obs;
  final book_detail=[];


  book_details() async{
    print('phone-------------${userData!.phoneNumber}');
    // bookList.clear();
    isLoading(true);

    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'libraryItemDetails'),
        body: {
      "user_id" : userData!.userId,
      "order_id" : widget.bookid.toString(),
    });

    var data=jsonDecode(response.body);
    status.value=data['success'];

    log("data--------------------------------$data");

    if (data['success'] == true) {

      print(response);
      print(response.body);

      book_detail.addAll(data['data']);



      print("88888*******");
      print("==============$book_detail");
      if(book_detail[0]['item_type'].toString()=='2'){
        isLoading(false);
      }else{
        await download();
      }


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




  download() async {
    if (Platform.isAndroid || Platform.isIOS) {
      String? firstPart;
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      if (allInfo['version']["release"].toString().contains(".")) {
        int indexOfFirstDot = allInfo['version']["release"].indexOf(".");
        firstPart = allInfo['version']["release"].substring(0, indexOfFirstDot);
      } else {
        firstPart = allInfo['version']["release"];
      }
      int intValue = int.parse(firstPart!);

      print('intValue-----------------------${intValue}');
      if (intValue >= 13) {
        await startDownload();
      } else {
        if (await Permission.storage.isGranted) {
          await Permission.storage.request();
          await startDownload();
        } else {
          await startDownload();
        }
      }
    } else {
      isLoading.value = false;
    }
  }
  startDownload() async {
    print('epub_book---------------------${ApiService.IMAGE_URL+book_detail[0]['epub_book']}');
    final dio = Dio();
    Directory? appDocDir = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
    print('appDocDir-----------------------${appDocDir}');
    String path = appDocDir!.path + '/xyz.epub';
    print('path-----------------------${path}');
    File file = File(path);

    print('file-----------------------${file}');

    if (!File(path).existsSync()) {
      print('file-----------------------');
      await file.create();
      await dio.download(
        "${ApiService.IMAGE_URL+book_detail[0]['epub_book']}",
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          setState(() {
            isLoading.value = true;
          });
        },
      ).whenComplete(() {
        setState(() {
          isLoading.value = false;
          filePath.value = path;
        });
      });
    } else {
      setState(() {
        isLoading.value = false;
        filePath.value = path;
      });
    }
  }

  final List<Item> _data = generateItems(1);
  final List<Item> _data1 = generateItems(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Library Details'),
      ),
      body: isLoading==true?
      Center(child: CupertinoActivityIndicator()):
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CachedNetworkImage(
                        imageUrl:ApiService.IMAGE_URL+'${book_detail[0]['image'].toString()}',),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '${book_detail[0]['title']}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        book_detail[0]['publisher_name'].toString().isNotEmpty?
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 05,bottom: 05,right: 05),
                          child: Text(
                            '${book_detail[0]['publisher_name']??""}',
                            style: TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                        ):
                        Container(),


                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 8),
                          child: Container(
                            child: RatingBar.builder(
                              ignoreGestures: true,
                              updateOnDrag: true,
                              glow: false,
                              itemSize: 20,
                              initialRating: double.parse(book_detail[0]['review_rating'].toString()),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ElevatedButton(
                            child: const Text(
                              "Read Now",
                              style: TextStyle(
                                  fontSize: 14.5, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {


                              _settingModalBottomSheet(context);




                            },
                          ),
                        ),
                      ],
                    ),

                  ),
                ],
              ),
            ),
            Card(
              elevation: 5,
              child: Column(
                children: [
                  const Divider(
                    thickness: 1.3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8.0),
                    child: InkWell(
                      onTap: () async{
                        book_detail[0]['is_rating'].toString()=='0'?
                        Get.bottomSheet(
                          ReviewBottomSheet(
                              data: widget.bookid.toString(),
                                  Ontap:(){
                                    book_details();
                        }
                          ),
                          backgroundColor: Colors.transparent,
                          isDismissible: false,
                        )
                            :
                        snackbar('Review already submitted.');

                        // _showReviewBottomSheet(context);
                      /*showModalBottomSheet(
                          context: context,
                          builder: (context) => RatingWidget(

                              controller: PrintRatingController(ratingModel)


                          ),
                        );*/





                      },
                      child: Row(
                        children: const [
                          Text(
                            "Write a review",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          Icon(
                            Icons.expand_more,
                            size: 25,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 1.3,
                    height: 0,
                  ),
                  _buildPanelOrder(),
                  const Divider(
                    thickness: 1.3,
                    height: 0,
                  ),
                  _buildPanelShipment(),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildPanelOrder() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'View order details',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            );
          },
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.grey),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text("Order Date"),
                            Text(
                              '${book_detail[0]['order_date'].toString()}',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text("Order ID"),
                            Text(
                              '${book_detail[0]['order'].toString()}',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text("Order Total"),
                            Text(
                              "₹ ${book_detail[0]['order_total'].toString()}.00 (1 Item)",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1.3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Download Invoice",
                              style: TextStyle(fontSize: 14),
                            ),
                            Icon(Icons.chevron_right)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  Widget _buildPanelShipment() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data1[index].isExpanded = !isExpanded;
        });
      },
      children: _data1.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Payment Information',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            );
          },
          body: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 15),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          'Payment Method',
                          style: TextStyle(fontWeight: FontWeight.bold,),
                        ),
                        Text('${book_detail[0]['payment_method'].toString()}'??''),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1.3,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 6.0),
                    child: Text(
                      "Billing Address",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(left: 6.0),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        '${book_detail[0]['payment_address']??''}',
                      style: TextStyle(

                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }


  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.picture_as_pdf),
                  title: const Text('Open with PDF'),
                  onTap: (){

                    if(book_detail[0]['item_type'].toString()=='2'){
                      print('pdf sned-----------${book_detail[0]['item_type'].toString()}');
                      var data={
                        'pdf_url':book_detail[0]['read_now_file'].toString(),
                        'bookId': book_detail[0]['id'].toString(),
                        'title': book_detail[0]['title'].toString(),
                        'is_main_audio': book_detail[0]['is_main_audio'].toString(),
                        'notedetails':'true',
                      };
                      Get.toNamed(Routes.PDF_VIEWER,parameters: data);

                    }else{
                     // print('pdf sned-----------${controller.book_detils[0]['sample_book'].toString()}');

                      var data={
                        'pdf_url':book_detail[0]['read_now_file'].toString(),
                        'bookId': book_detail[0]['id'].toString(),
                        'title': book_detail[0]['title'].toString(),
                        'is_main_audio': book_detail[0]['is_main_audio'].toString(),
                        'notedetails': 'false',
                      };
                      Get.toNamed(Routes.PDF_VIEWER,parameters: data);
                    }


                  }
              ),
              book_detail[0]['item_type'].toString()=='2'?
              Container():
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text('Open with Epub'),
                onTap: () async {

                  if(filePath.value==''){
                    download();
                  }else{


                    VocsyEpub.setConfig(
                      themeColor: Theme.of(context).primaryColor,
                      identifier: "iosBook",
                      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
                      allowSharing: false,
                      enableTts: true,
                      nightMode: false,
                    );

                    // get current locator
                    VocsyEpub.locatorStream.listen((locator) {
                      print('LOCATOR: $locator');
                    });

                    VocsyEpub.open(
                      filePath.value,
                      /*lastLocation: EpubLocator.fromJson({
                        "bookId":  book_detail[0]['id'].toString(),
                        "href": "/OEBPS/ch06.xhtml",
                        "created": 1539934158390,
                        "locations": {"cfi": ""}
                      }),*/
                    );
                  }


                },
              )
            ],
          );
        }
    );
  }

 

}

/*class PrintRatingController extends RatingController {
  PrintRatingController(RatingModel ratingModel) : super(ratingModel);
  @override
  Future<void> ignoreForEverCallback() async {
    if (kDebugMode) {
      print('Rating ignored forever!');
    }
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Future<String> saveRatingCallback(int rate, List<RatingCriterionModel> selectedCriterions) async {
    if (kDebugMode) {
      print('Rating saved!\nRate: $rate\nsSelectedItems: $selectedCriterions');

    }
    await Future.delayed(const Duration(seconds: 3));

    return rate.toString();
  }
}

final ratingModel = RatingModel(
  id: 1,
  title: null,
  subtitle: 'Rate National Digital Notes',
  ratingConfig: RatingConfigModel(
    id: 1,
    ratingSurvey1: 'Shit !',
    ratingSurvey2: 'You rate me 2/5 Stars, What happened',
    ratingSurvey3: 'OK ! You rate me 3/5 Stars',
    ratingSurvey4: 'Great ! You rate me 4/5 Stars',
    ratingSurvey5: 'Wow ! You rate me 5/5 Stars',
    items: [
      RatingCriterionModel(id: 1, name: 'Best Quality Books'),
      RatingCriterionModel(id: 2, name: 'Best Services'),
      RatingCriterionModel(id: 3, name: 'Quick Payments'),
      RatingCriterionModel(id: 4, name: 'Good User Interface'),
    ],
  ),
);*/
class ReviewBottomSheet extends StatelessWidget {
  final String data;
  final Function Ontap;

  ReviewBottomSheet({required this.data,required this.Ontap});
  final isLoading=false.obs;
  final Rating='2.0'.obs;

  TextEditingController reviewController = TextEditingController();

  Future<bool?> Review({rating,rating_text,context}) async {
    try {
      isLoading(true);
      var response = await ApiService().ReviewSubmit(order_id: data.toString(),user_id: userData!.userId,rating: rating,rating_text:rating_text);
      print({'response==================================$response'});

      if (response['success'] == true) {
        snackbar(response['message']);
        Ontap();
        isLoading(false);
        return true;


      } else if (response['success'] == false) {
        snackbar(response['message']);
        isLoading(false);
        return true;
      }

    } finally {
      isLoading(false);


    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
       // height: MediaQuery.of(context).size.height/2,
        padding: EdgeInsets.all(16.0),
        child: Obx(()=>
           Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Write a review',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              ///ratting bar implement
              ///-------------------->
              Flexible(
                child: Container(
                  child: RatingBar.builder(

/*              ignoreGestures: true,
                    updateOnDrag: true,
                    glow: true,*/
                    itemSize: 30,
                    initialRating: double.parse(2.toString()),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      Rating.value=rating.toString();
                      print('Rating-----------------${Rating.value}');
                      print(rating);
                    },
                  ),
                ),
              ),


              SizedBox(height: 16),
              TextField(
                controller: reviewController,
                decoration: InputDecoration(
                  hintText: 'Enter your review here',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () async{

                  if(reviewController.text.isNotEmpty){
                    bool? istrue= await Review(rating: Rating.value,rating_text: reviewController.text);
                    if(istrue!){
                      Navigator.pop(context);
                    }
                  }else{
                    snackbar('Please enter your review here.');
                  }





                  // TODO: Implement submit functionality
                 // Navigator.pop(context); // Close the bottom sheet
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Submit',textAlign: TextAlign.center,),
                    isLoading.value==true?
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CupertinoActivityIndicator(color: Colors.white,),
                        ):
                        Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}