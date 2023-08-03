import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/constants/api_service.dart';
import '../../utils/global_widgets/snackbar.dart';
import '../buy_now_view/buy_now_screen.dart';
import '../order_placed_screen/order_placed_view.dart';
import 'package:http/http.dart' as http;
class AddToCartView extends StatefulWidget {
  const AddToCartView({super.key});

  @override
  State<AddToCartView> createState() => _AddToCartViewState();
}

class _AddToCartViewState extends State<AddToCartView> {


  @override
  void initState() {
    callApi();
    // TODO: implement initState
    super.initState();
  }



  final isLoading=false.obs;
  var data;
  final status=false.obs;
  var cart_list=[].obs;

  callApi() async{
    //print('bookid====================${widget.bookid}');
    cart_list.clear();
    isLoading(true);


    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'addToCartList'),body: {
      "user_id":userData!.userId,
    });



    data=jsonDecode(response.body);

    status.value=data['success'];

    print("dataaaa=======================$data");

    if (data['success'] == true) {

      print(response);
      print(response.body);
      cart_list.addAll(data['data']);
      //book_detils.value = data['data'];
      print("88888*******");
      print("cart_list========================$cart_list");

      for(int i=0;i<cart_list.length;i++){
        Add_to_cart_isLoading.add(false);
      }



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


  /*Remove_cart(item_id,item_type) async{
    //print('bookid====================${widget.bookid}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id=prefs.getString('user_id');
    print("===user id------------------$user_id");
    print("===item_id id------------------$item_id");
    print("===item_type id------------------$item_type");


    http.Response response = await http.post(Uri.parse('https://ndn.manageprojects.in/api/removeToCart'),body: {
      "user_id":user_id,
      "item_id": item_id,
      "item_type":item_type,
    },
      headers: {HttpHeaders.acceptHeader: "application/json"},
    );

    print("===========================${jsonDecode(response.body)}");

  }*/

  final Add_to_cart_isLoading=[].obs;

  removeToCart(item_id,item_type,index) async{

    print("item_id======================================${item_id}");
    print("item_type======================================${item_type}");

    // bookList.clear();
    Add_to_cart_isLoading[index]=true;
    setState(() {

    });

    //print("user_id======================================${user_id}");
    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'removeToCart'),body: {
      "user_id": userData!.userId,
      "item_id": item_id,
      "item_type": item_type,
    });

    var data=jsonDecode(response.body);
    status.value=data['success'];

    snackbar(data['message']);

    print("data===============================$data");

    if (data['success'] == true) {

      Add_to_cart_isLoading[index]=false;

      setState(() {

      });
      //update();
    } else if (data['success'] == false) {
      //book_detils.value = data;
      Add_to_cart_isLoading[index]=false;

      setState(() {
      });
    }

  }
  int qn = 0;
  bool shouldPop = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Your Cart - (${cart_list.length})"),
              leading: IconButton(
                onPressed: (){
                  Get.back(result: 'hello');
                },
                icon:Icon(Icons.arrow_back_outlined),
                //replace with our own icon data.
              )
          ),
          body: isLoading==false? cart_list.isEmpty
              ?  Center(
                  child: Text("Cart Is Empty"),
                )
              : Column(
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.to(const AllAddressScreen());
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     color: Colors.blue.shade200,
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: const [
                    //         SizedBox(
                    //           width: 20,
                    //         ),
                    //         Icon(Icons.gps_fixed_outlined),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text("Deliver to Tanmay - Indore 452001")
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: cart_list.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  color: Colors.grey.shade200,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                        /*  setState(() {
                                            cart_list.removeAt(index);
                                          });*/
                                        },
                                        leading: Container(
                                          //height: 100,
                                          width: 60,
                                          child: CachedNetworkImage(
                                              imageUrl:
                                              ApiService.IMAGE_URL+cart_list[index]['image']),
                                        ),
                                        title: Text(cart_list[index]['title']),
                                        subtitle: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(cart_list[index]['heading']),
                                            // const Text(
                                            //   'Tap to Remove Item',
                                            //   style:
                                            //   TextStyle(color: Colors.blue),
                                            // ),
                                          ],
                                        ),
                                        isThreeLine: true,
                                        trailing: Text(
                                          "₹ ${cart_list[index]['item_price'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          /* Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  shape: BoxShape.circle),
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (qn != 0) {
                                                        qn--;
                                                      }
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    size: 15,
                                                  )),
                                            ),*/
                                          /* const SizedBox(
                                              width: 10,
                                            ),
                                            Text("$qn"),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  shape: BoxShape.circle),
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      qn++;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    size: 15,
                                                  )),
                                            ),*/
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Add_to_cart_isLoading[index]==true?
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: CupertinoActivityIndicator(),
                                                ):
                                                IconButton(
                                                    onPressed: () async{
                                                      await removeToCart(cart_list[index]['item_id'].toString(),cart_list[index]['item_type'].toString(),index);
                                                      cart_list.removeAt(index);
                                                      setState(() {

                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      size: 20,
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 50,
                      width: double.maxFinite,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to( BuyNowScreen());

                            /*Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              Get.to(const OrderPlaced());
                            });*/
                          },
                          child:
                              //const Text("Proceed to Buy (Rs. 5499 - 5 Items)")),
                           const Text("Proceed to Buy")),
                    )

                  ],
                ):
              Center(child: CupertinoActivityIndicator())
      ),
    );
  }
}

class CartModels {
  String bookName;
  String price;
  String imageURL;
  String description;

  CartModels(
      {required this.bookName,
      required this.imageURL,
      required this.description,
      required this.price});
}
