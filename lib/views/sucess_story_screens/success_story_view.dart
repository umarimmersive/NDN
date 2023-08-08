import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/api_service.dart';
class SuccessStory extends StatefulWidget {
  const SuccessStory({Key? key}) : super(key: key);

  @override
  State<SuccessStory> createState() => _SuccessStoryState();
}

class _SuccessStoryState extends State<SuccessStory> {



  @override
  void initState() {
    callApi();
    // TODO: implement initState
    super.initState();
  }

  var SucessStory=[].obs;
  bool is_loder=false;
  var data;
  var SucessStory_title;



  callApi() async{
    is_loder=true;
    http.Response response =await http.get(Uri.parse(ApiService.BASE_URL+'successStories'));
    print(response);
    print(response.body);

     data=jsonDecode(response.body);
    if(data['success']==true){
      SucessStory.addAll(data['data']);

      print("=================#$SucessStory");
      is_loder=false;

      setState(() {

      });
    }else{

      is_loder=false;

    }
    setState(() {

});

  }

  List imagesURL = [
    'assets/books_covers/1.jpg',
    'assets/books_covers/3.jpg',
    'assets/books_covers/4.jpg',
    'assets/books_covers/5.jpg',
    'assets/books_covers/6.jpg'
  ];

  List name = [
    'Shubham Chouksey',
    'Prakritish Bhattacharyya',
    'Abhishek Nishad',
  ];

  List comments = [
    'Best app for UPSC CSE preparation for beginners as well as repeaters. I have downloaded more than 100 apps and found this app very useful and plans are also affordable.',
    'Excellent app. Suggestion: please upgrade dashboard in Grid pattern instead of List pattern. This would be very helpful and easy visible also because there is no provision of font size adjustment. That also be included.',
    'It is very helpful for UPSE aspirants as well as those who want to give state pcs.it provides previous year questions with topic wise which is very helpful for analysis exam requirements. however he doesnt provide pyqs for optional subject.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Success Story"),
      ),
      body: is_loder==true?Center(child: CupertinoActivityIndicator(),):
      data['success']==true?
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topCenter,
            width: 350,
            child:  Text(
              "${data['title']}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
           SizedBox(
            height: 20,
          ),
          Center(
            child: CarouselSlider(
              options: CarouselOptions(height: 500.0),
              items: SucessStory.map((i) {
                print("index==========${i}");
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              const SizedBox(
                                height: 20,
                              ),

                             /* Container(
                                height: 100,
                                width: double.infinity,
                                child: Image.network('https://ndn.manageprojects.in/'+i['image']),
                              ),*/
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height/3,
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    ApiService.IMAGE_URL+i['image'],
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(02),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  '"${i['story']}"',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),

                              Flexible(
                                child: Container(
                                  child: RatingBar.builder(
                                    ignoreGestures: true,
                                    updateOnDrag: true,
                                    glow: false,
                                    itemSize: 20,
                                    initialRating: double.parse(i['rating'].toString()),
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

                              SizedBox(
                                height: 10,
                              ),

                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "${i['name'].toString()}",
                                  style: const TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ));
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ):
          Center(child: Text('data not found'),)
    );
  }
}
