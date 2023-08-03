import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/controllers/address_controller.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:national_digital_notes_new/views/deliver_to_screen/deliver_to_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

import '../../app/modules/Pre_onlineTest_instruction/views/BottomBarWithButton.dart';
import '../../utils/constants/api_service.dart';
import '../specific_book_details_screen/specific_book_details_controller.dart';
// ignore: must_be_immutable
class BuyNowScreen extends StatefulWidget {


  BuyNowScreen({super.key,});

  @override
  State<BuyNowScreen> createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {

  static const platform = MethodChannel('samples.flutter.dev/battery');
  int qn = 0;
  AddressController addressController = Get.put(AddressController());
  specific_book_details_controller cont = Get.put(specific_book_details_controller());

  String? payment;

  @override
  void initState() {
    Order_details();
    // TODO: implement initState
    super.initState();
  }

  final isLoading=false.obs;
  var data;
  final status=false.obs;
  var order_details_list=[].obs;

  Order_details() async{
    order_details_list.clear();
    isLoading(true);
    http.Response response = await http.post(Uri.parse(ApiService.orderDetails),body: {
      "user_id":userData!.userId,
    });
    data=jsonDecode(response.body);

    status.value=data['success'];

    print("dataaaa=======================$data");

    if (data['success'] == true) {
      print(response);
      print(response.body);
      order_details_list.addAll(data['data']);
      //book_detils.value = data['data'];
      print("88888*******");
      print("cart_list========================$order_details_list");

      setState(() {

      });


      isLoading(false);
      //update();
    } else if (data['success'] == false) {
      //book_detils.value = data;
      isLoading(false);
      setState(() {

      });
    }

  }


  Buy_card_product({transaction_id,payment_status}) async{
    isLoading(true);
    http.Response response = await http.post(Uri.parse(ApiService.checkOutAllOrder),body: {
      "user_id":userData!.userId,
      "transaction_id":transaction_id,
      "payment_status":payment_status,
      "payment_method":"online",
      "payment_address":" ",
    });
   var data=jsonDecode(response.body);
    status.value=data['success'];

    log("=========$data");

    if (data['success'] == true) {
      print('---------------------payment success');
      isLoading(false);
    } else if (data['success'] == false) {
      isLoading(false);
    }

  }






  @override
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: BottomBarWithButton(
          buttonText: "Checkout",
          onPressed: () {
            incrementCounter(price:data['total_amount'].toString());
          },
        ),
      // backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: isLoading==true?
      Center(child: CupertinoActivityIndicator()):
      data['success']==true?
      SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),

                for(int i=0;i<order_details_list.length;i++)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CachedNetworkImage(
                                imageUrl:ApiService.IMAGE_URL+order_details_list[i]['image']),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${order_details_list[i]['heading']}',
                                 maxLines: 1,
                                style: const TextStyle(fontSize: 16),
                              ),
                              Flexible(
                                child: Text(
                                    '${order_details_list[i]['title']}',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey.shade700),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),


                              Flexible(
                                child: Container(
                                  child: RatingBar.builder(
                                    ignoreGestures: true,
                                    updateOnDrag: true,
                                    glow: false,
                                    itemSize: 20,
                                    initialRating: double.parse(order_details_list[i]['rating'].toString()),
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
                                children:  [
                                  Text(
                                    "₹ ${order_details_list[i]['item_price']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 1.2,
                                        color: Colors.green),
                                  ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  // Text(
                                  //   "₹ 1549",
                                  //   style: TextStyle(
                                  //       decoration: TextDecoration.lineThrough,
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 16,
                                  //       letterSpacing: 1.2,
                                  //       color: Colors.black),
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // SizedBox(
                              //     height: 35,
                              //     width: MediaQuery.of(context).size.width * 0.4,
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       crossAxisAlignment: CrossAxisAlignment.center,
                              //       children: [
                              //         Container(
                              //           decoration: BoxDecoration(
                              //               color: Colors.grey.shade300,
                              //               shape: BoxShape.circle),
                              //           child: IconButton(
                              //               onPressed: () {
                              //                 setState(() {
                              //                   if (qn != 0) {
                              //                     qn--;
                              //                   }
                              //                 });
                              //               },
                              //               icon: const Icon(
                              //                 Icons.remove,
                              //                 size: 20,
                              //               )),
                              //         ),
                              //         Text("$qn"),
                              //         Container(
                              //           decoration: BoxDecoration(
                              //               color: Colors.grey.shade300,
                              //               shape: BoxShape.circle),
                              //           child: IconButton(
                              //               onPressed: () {
                              //                 setState(() {
                              //                   qn++;
                              //                 });
                              //               },
                              //               icon: const Icon(
                              //                 Icons.add,
                              //                 size: 20,
                              //               )),
                              //         ),
                              //         // IconButton(
                              //         //     onPressed: () {
                              //         //
                              //         //     },
                              //         //     icon: const Icon(Icons.delete))
                              //       ],
                              //     )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1.2,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 15,
                ),
              /*  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print("About this eBook");
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Payment Method",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: RadioListTile(
                                title: const Text("Online"),
                                value: "Online",
                                groupValue: payment,
                                onChanged: (value) {
                                  setState(() {
                                    payment = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),*/
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print("About this eBook");
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Order Info",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text('Subtotal'),
                            Text(
                              '₹ ${data['sub_total'].toString()}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      /*  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text('Shipping cost'),
                            Text(
                              '₹ ${data['shipping_cost'].toString()}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ],
                        ),*/
                      /*  const SizedBox(
                          height: 10,
                        ),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text(
                              'Total',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '₹ ${data['total_amount'].toString()}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              /*  SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          incrementCounter(price:data['total_amount'].toString());
                        },
                        child: const Text("Checkout"))),
                const SizedBox(
                  height: 15,
                ),*/
              ],
            ),
          ),
        ):
          Center(child: Text('No data found'),)

    );
  }
  void incrementCounter({price}) async{

    print('price------------------$price');
    final List<Object?> result = await platform.invokeMethod('callSabPaisaSdk',[userData!.name,"",userData!.emailId,userData!.phoneNumber,price]);

    String txnStatus = result[0].toString();
    String txnId = result[1].toString();
    if(txnStatus.toString()=="SUCCESS"){


   await Buy_card_product(payment_status: txnStatus.toString(),transaction_id: txnId.toString());
    //  cont.PlaceOrder(transaction_id: txnId,item_price: price,item_type: cont.Type.value,payment_status: txnStatus.toString());
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


    /* print('result-------------------------------$result');
    Fluttertoast.showToast(
        msg: txnStatus,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );*/

  }
}
