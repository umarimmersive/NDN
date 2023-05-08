import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/testing_epub.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rating/rating.dart';
import 'package:http/http.dart' as http;
// ignore: must_be_immutable
class DetailedBooksOrder extends StatefulWidget {

  String bookid;
  /*


  String bookName;
  String imageURL;
  String orderedDate;*/

  DetailedBooksOrder(
      {super.key,
        required this.bookid,
     /* required this.bookName,

      required this.imageURL,
      required this.orderedDate*/});

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
    print("pi=========================");
    book_details();
    // TODO: implement initState
    super.initState();
  }

  final isLoading=false.obs;
  final status=false.obs;
  final book_detail=[];


  book_details() async{
    // bookList.clear();
    isLoading(true);



    http.Response response = await http.post(Uri.parse('https://ndn.manageprojects.in/api/libraryItemDetails'),body: {
      "user_id":userData!.userId,
      "order_id":widget.bookid.toString(),

    });

    var data=jsonDecode(response.body);
    status.value=data['success'];

    log("=========$data");

    if (data['success'] == true) {

      print(response);
      print(response.body);
      book_detail.addAll(data['data']);
      print("88888*******");
      print("==============$book_detail");
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












  final List<Item> _data = generateItems(1);
  final List<Item> _data1 = generateItems(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading==true?Center(child: CupertinoActivityIndicator()):ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network('https://ndn.manageprojects.in/'+'${book_detail[0]['image'].toString()}',),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${book_detail[0]['title']}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                         Text(
                          '${book_detail[0]['details']??"NA"}',
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                         Flexible(
                          child: Text(
                            '${book_detail[0]['description']??"NA"}',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: SizedBox(
                            height: 30,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: const [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star_border,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                            child: ElevatedButton(
                          child: const Text(
                            "Read Now",
                            style: TextStyle(
                                fontSize: 14.5, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                           // Get.to(EPUBTEST());
                          },
                        )),
                      ],
                    ),
                  ),
                ],
              ),
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
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => RatingWidget(
                            controller: PrintRatingController(ratingModel)),
                      );
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

          // ),
        ],
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
                            Text("Order #"),
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
                              "₹ '${book_detail[0]['order_total'].toString()}'.00 (1 Item)",
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
                              style: TextStyle(fontSize: 12),
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
              height: MediaQuery.of(context).size.height * 0.3,
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
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                    padding: EdgeInsets.only(left: 4.0),
                    child: SizedBox(
                      width: 100,
                      child: Text(
                          '${book_detail[0]['payment_address'].toString()}'??'',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
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
}

class PrintRatingController extends RatingController {
  PrintRatingController(RatingModel ratingModel) : super(ratingModel);

  @override
  Future<void> ignoreForEverCallback() async {
    if (kDebugMode) {
      print('Rating ignored forever!');
    }
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Future<void> saveRatingCallback(
      int rate, List<RatingCriterionModel> selectedCriterions) async {
    if (kDebugMode) {
      print('Rating saved!\nRate: $rate\nsSelectedItems: $selectedCriterions');
    }
    await Future.delayed(const Duration(seconds: 3));
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
);
