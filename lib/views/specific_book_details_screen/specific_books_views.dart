
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:national_digital_notes_new/views/specific_book_details_screen/specific_book_details_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import '../../utils/routes/app_pages.dart';
import '../add_to_cart_screen/add_to_cart_view.dart';
import 'about_this_ebook_view.dart';
import 'package:http/http.dart' as http;

class specific_books_views extends GetView<specific_book_details_controller>{
  static const platform = MethodChannel('samples.flutter.dev/battery');
  @override
  Widget build(BuildContext context) {
   /* if (kDebugMode) {
      print("Book Name : ${controller.bookName}, Image URL : ${controller.imageURL}");
    }*/

    return
     Obx(() => Scaffold(
         backgroundColor: Colors.blue.shade50,
         appBar: AppBar(
           title: Text(controller.bookName.value),
           actions: [
             IconButton(
                 onPressed: () async{
                   final result =  await Get.to(const AddToCartView());
                   if(result != null){
                     controller.onInit();
                   }

                 },
                 icon: const Icon(Icons.shopping_cart))
           ],
         ),

         body:
         controller.isLoading==false ?
         controller.data['success'] !=true?  Center(child: Text('No data found')):
         ListView(
             children: [
           Column(
             children: [
               const SizedBox(
                 height: 20,
               ),
               SizedBox(
                 height: MediaQuery.of(context).size.height * 0.25,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Expanded(
                       child: Padding(
                         padding: const EdgeInsets.all(20.0),
                         child: CachedNetworkImage(
                             imageUrl: controller.imageURL.value),
                       ),
                     ),
                     Expanded(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Expanded(
                             flex: 8,
                             child: Padding(
                               padding: const EdgeInsets.only(top: 05.0),
                               child: Text(
                                 controller.book_detils[0]['book_name']!=null?controller.book_detils[0]['book_name']:controller.book_detils[0]['title'].toString(),
                                 overflow: TextOverflow.ellipsis,
                                 maxLines: 2,
                                 style: const TextStyle(fontSize: 16),
                               ),
                             ),
                           ),
                           Expanded(
                             flex: 2,
                             child: Container(
                               child: Text(
                                 overflow: TextOverflow.ellipsis,
                                 controller.category.toString().replaceAll(',', ''),
                                 maxLines: 1,
                                 style: TextStyle(
                                     fontSize: 12, color: Colors.grey.shade700),
                               ),
                             ),
                           ),
                           const SizedBox(
                             height: 5,
                           ),
                           Flexible(
                             child: Container(
                               child: RatingBar.builder(
                                 ignoreGestures: true,
                                 updateOnDrag: true,
                                 glow: false,
                                 itemSize: 20,
                                 initialRating: double.parse(controller.book_detils[0]['rating'].toString()),
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
                           const SizedBox(
                             height: 10,
                           ),
                           Row(
                             children: [
                               controller.free == "true"
                                   ? const Text(
                                 "FREE",
                                 style: TextStyle(
                                     color: Colors.orange,
                                     fontSize: 18,
                                     fontWeight: FontWeight.bold),
                               )
                                   :  Text(
                                 "₹${controller.book_detils[0]['selling_price']}",
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 18,
                                     letterSpacing: 1.2,
                                     color: Colors.green),
                               ),
                               const SizedBox(
                                 width: 10,
                               ),
                               /*const Text(
                              "₹ 1549",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 1.2,
                                  color: Colors.black),
                            ),*/
                             ],
                           ),
                           const SizedBox(
                             height: 10,
                           ),
                           SizedBox(
                             height: 35,
                             width: MediaQuery.of(context).size.width * 0.4,
                             child: ElevatedButton(
                               onPressed: () async{

                                 incrementCounter(price: controller.book_detils[0]['selling_price'].toString());
                               },
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: const [
                                   Icon(Icons.shopping_cart),
                                   Text(
                                     "BUY NOW",
                                     style: TextStyle(fontWeight: FontWeight.bold),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
               const SizedBox(
                 height: 10,
               ),
               const Divider(
                 thickness: 1.2,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   OutlinedButton(
                       onPressed: () {
                         _settingModalBottomSheet(context);
                       },
                       style: OutlinedButton.styleFrom(
                         //<-- SEE HERE
                         side: const BorderSide(width: 1.0, color: Colors.grey),
                       ),
                       child:  Text(
                         'Read Sample',
                         style: TextStyle(fontSize: 11),
                       )
                   ),
                   Flexible(
                     child: OutlinedButton(
                         onPressed: () async{

                           // setState(() {
                           //   isFaved = !isFaved;
                           // });
                           if(controller.book_detils[0]['is_fav']==1){
                             await controller.Remove_wishlist();
                             controller.book_detils[0]['is_fav']=0;

                           }else{
                             await controller.Add_fev();
                             controller.book_detils[0]['is_fav']=1;
                           }

                           // Get.to(PDFSYNC(
                           //   bookName: widget.bookName,
                           // ));
                         },
                         style: OutlinedButton.styleFrom(
                           //<-- SEE HERE
                           side: const BorderSide(width: 1.0, color: Colors.grey),
                         ),
                         child: Column(
                           children: <Widget>[
                             controller.book_detils[0]['is_fav']==1?
                             Text(
                               'Remove from Wishlist',
                               style: TextStyle(fontSize: 10),
                             )
                                 :
                             Text(
                               'Add to Wishlist',
                               style: TextStyle(fontSize: 10),
                             ),

                             controller.wishlist_isLoading==true?
                             CupertinoActivityIndicator():
                             SizedBox()



                           ],)

                     ),
                   ),
                   ElevatedButton(
                     onPressed: () async{
                       // setState(() {
                       //   isFaved = !isFaved;
                       // });
                       if(controller.book_detils[0]['is_cart']==1){

                         await controller.removeToCart();

                         controller.book_detils[0]['is_cart']=0;


                       }else{

                         await controller.Add_to_cart(controller.book_detils[0]['selling_price'].toString());
                         controller.book_detils[0]['is_cart']=1;


                       }
                     },
                     child:
                     Column(
                       children: [
                         controller.book_detils[0]['is_cart']==0?
                         Text(
                           "Add to Cart",
                           style: TextStyle(fontSize: 10),
                         ):
                         Text(
                           "Remove Cart",
                           style: TextStyle(fontSize: 10),
                         ),
                         controller.Add_to_cart_isLoading==true?
                         CupertinoActivityIndicator():
                         SizedBox()
                       ],
                     ),

                   )

                 ],
               ),
               const SizedBox(
                 height: 15,
               ),
               const SizedBox(
                 height: 10,
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
                 child: Column(
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                           "About this eBook",
                           style: TextStyle(color: Colors.black, fontSize: 18),
                         ),
                         GestureDetector(
                           onTap: (){
                             Get.to(
                               AboutThisEBook(
                                 bookName: controller.book_detils[0]['book_name']!=null?controller.book_detils[0]['book_name']:controller.book_detils[0]['title'].toString(),
                                 description:controller.book_detils[0]['description'].toString()??"",
                               ),);
                           },
                           child: Icon(
                             Icons.arrow_forward_ios,
                             color: Colors.blue,
                           ),
                         )

                       ],
                     ),
                     Text(
                       maxLines: 5,
                       overflow: TextOverflow.ellipsis,
                       "${controller.book_detils[0]['description'].toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ') ?? ''}",
                       style: TextStyle(fontSize: 13),
                     ),
                   ],
                 ),
               ),
               const SizedBox(
                 height: 15,
               ),
               Padding(
                 padding:EdgeInsets.symmetric(horizontal: 18.0,vertical: 5),
                 child: Container(
                   alignment: Alignment.centerLeft,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children:  [
                       Text(
                         "Published",
                         style: TextStyle(color: Colors.black, fontSize: 18),
                       ),
                       Text(
                         "${controller.book_detils[0]['publish_date']} * GENERAL PRESS",
                         style: TextStyle(fontSize: 13),
                       ),
                     ],
                   ),
                 ),
               ),
             ],
           ),
         ]):
         Center(child: CupertinoActivityIndicator())


     ));
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

                    if(controller.notedetails.value=='true'){
                      print('pdf sned-----------${controller.book_detils[0]['sample_note'].toString()}');
                         var data={
                             'pdf_url':controller.book_detils[0]['sample_note'].toString(),
                             'bookId': controller.book_detils[0]['id'].toString(),
                             'title': controller.book_detils[0]['title'].toString(),
                             'notedetails': controller.notedetails.toString(),
                            };
                      Get.toNamed(Routes.PDF_VIEWER,parameters: data);
                      //Get.to( TestingPDF(pdf_url:controller.book_detils[0]['sample_note']))
                    }else{
                      print('pdf sned-----------${controller.book_detils[0]['sample_book'].toString()}');

                      var data={
                        'pdf_url':controller.book_detils[0]['sample_book'].toString(),
                        'bookId': controller.book_detils[0]['id'].toString(),
                        'title': controller.book_detils[0]['book_name'].toString(),
                        'notedetails': controller.notedetails.toString(),
                      };
                      Get.toNamed(Routes.PDF_VIEWER,parameters: data);
                    }
                   // print("simplebook--------------------${book_detils[0]['sample_book']}"),

                  }
              ),
              controller.notedetails.value=='true'?
              Container():
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text('Open with Epub'),
                onTap: () async {

                  if(controller.loading.value){

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
                      controller.filePath.value,
                      lastLocation: EpubLocator.fromJson({
                        "bookId": "2239",
                        "href": "/OEBPS/ch06.xhtml",
                        "created": 1539934158390,
                        "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
                      }),
                    );
                  }


                },
              )
            ],
          );
        }
    );
  }

  void incrementCounter({price}) async{

    print('price------------------$price');
    final List<Object?> result = await platform.invokeMethod('callSabPaisaSdk',[userData!.name,"",userData!.emailId,userData!.phoneNumber,price]);

    String txnStatus = result[0].toString();
    String txnId = result[1].toString();
    if(txnStatus.toString()=="SUCCESS"){
      controller.PlaceOrder(transaction_id: txnId,item_price: price,item_type: controller.Type.value,payment_status: txnStatus.toString());
    }else{
      Fluttertoast.showToast(
          msg: txnStatus,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }


  }
}