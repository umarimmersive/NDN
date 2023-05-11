import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/buy_now_view/buy_now_screen.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/api_service.dart';
import '../../utils/global_widgets/globle_var.dart';
import '../../utils/routes/app_pages.dart';
import '../specific_book_details_screen/specific_books_views.dart';
class Wishlists extends StatefulWidget {
  const Wishlists({super.key});

  @override
  State<Wishlists> createState() => _WishlistsState();
}

class _WishlistsState extends State<Wishlists> {

@override
  void initState() {
  wish_list();
    // TODO: implement initState
    super.initState();
  }

/*
  List<BookLists> bookLists = [
    BookLists(
        imageURL: 'assets/books_covers/1.jpg',
        title: 'Jodi Picoult',
        desc: 'short Description for book'),
    BookLists(
        imageURL: 'assets/books_covers/1.jpg',
        title: 'Jodi Picoult',
        desc: 'short Description for book'),
    BookLists(
        imageURL: 'assets/books_covers/1.jpg',
        title: 'Jodi Picoult',
        desc: 'short Description for book'),
    BookLists(
        imageURL: 'assets/books_covers/1.jpg',
        title: 'Jodi Picoult',
        desc: 'short Description for book'),
    BookLists(
        imageURL: 'assets/books_covers/1.jpg',
        title: 'Jodi Picoult',
        desc: 'short Description for book'),
  ];
*/
  final wishlist=[].obs;
  final isLoder=false.obs;
  final wishlist_isLoading=false.obs;
  final wishlist_status = true;
  var ConvertDataToJson;



  wish_list() async{
    isLoder(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id=prefs.getString('user_id');

    print("user_id============================$user_id");
    setState(() {

    });
    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'wishList'),body: {
      "user_id": userData!.userId,
    });
    ConvertDataToJson = jsonDecode(response.body);




      if(ConvertDataToJson['success']==true){

        wishlist.addAll(ConvertDataToJson['data']);

        print("wishlist==================================$wishlist");
        setState(() {

        });

        isLoder(false);

      }else{
        isLoder(false);
      }
    setState(() {

    });

    //Toast.show("Something went wrong or No Connection !");
  }


  Remove_wishlist(itemid,itemtype) async{
    // bookList.clear();
    wishlist_isLoading(true);


  //  print("user_id============================${user_id}");
    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'removeFavorite'),body: {
      //"book_id":widget.bookid
      "user_id": userData!.userId,
      "item_id":itemid,
      "item_type":itemtype,
    });

    var data=jsonDecode(response.body);
    if (data['success'] == true) {

      wishlist_isLoading(false);

      setState(() {

      });
      //update();
    } else if (data['success'] == false) {
      //book_detils.value = data;
      wishlist_isLoading(false);
      setState(() {

      });
    }

  }

  /*{
  "id": 2,
  "user_id": 24,
  "item_id": 1,
  "item_type": 1,
  "type": "Book",
  "title": "Chemistry",
  "image": "uploads/books/1_book_cover.png"
  }*/



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Wishlist"),
        ),
        body: isLoder==true?
        Center(child: CupertinoActivityIndicator()):
        ConvertDataToJson['success']==false?
        Center(child: Text('Record Not Found.')):

         ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: wishlist.length,
               shrinkWrap: true,
              itemBuilder: (context, index) {
                return

                  // Expanded(
                  //     child:
                  //     Row(children: <Widget>[
                  //
                  //       Container(
                  //         width: 80,
                  //         height: 100,
                  //         child: CachedNetworkImage(
                  //           imageUrl:'https://ndn.manageprojects.in/'+wishlist[index]['image'],fit: BoxFit.fill,),
                  //       ),
                  //       Column(children: [
                  //         Text(wishlist[index]['title']),
                  //
                  //         Container(
                  //             child: Text(wishlist[index]['heading'],maxLines: 2, overflow: TextOverflow.ellipsis,)),
                  //
                  //       ],)
                  //       wishlist_isLoading==true?CupertinoActivityIndicator():SizedBox(
                  //         height: 100, width: 100,
                  //         child: IconButton(
                  //           icon: wishlist_status == true
                  //               ? const Icon(
                  //             Icons.favorite,
                  //             color: Colors.red,
                  //           )
                  //               : const Icon(Icons.favorite_border),
                  //           onPressed: () async{
                  //             await Remove_wishlist(wishlist[index]['item_id'].toString(),wishlist[index]['item_type'].toString());
                  //             setState(() {
                  //
                  //               bookLists[index].title, "Removed from wishlist");*//*
                  //               wishlist.removeAt(index);
                  //
                  //
                  //
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //
                  //     ],)
                  //
                  //
                  //
                  // );

                  ListTile(
                  onTap: () {


                    var data={
                      "notedetails": wishlist[index]['type'].toString()=='Note'? 'true': 'false',
                      'free': 'false',
                      'category':
                      "${wishlist[index]['title'].toString()}, ${''} ${wishlist[index]['exam_type_book'].toString()}",
                      'bookName':  wishlist[index]['title'].toString(),
                      'imageURL':  "${ApiService.IMAGE_URL+wishlist[index]['image'].toString()}",
                      'bookid': wishlist[index]['item_id'].toString().toString(),
                    };

                    Get.toNamed(Routes.SPECIFIC_BOOK_VIEW,parameters: data);


                  },
                  title: Text(wishlist[index]['title']),
                  leading: Container(
                    width: 80,
                    height: 100,
                    child: CachedNetworkImage(
                     imageUrl: ApiService.IMAGE_URL+wishlist[index]['image'],fit: BoxFit.fill,),
                  ),
                  subtitle: Container(
                      height: 50,width: 100,
                      child: Text(wishlist[index]['heading'],maxLines: 2, overflow: TextOverflow.ellipsis,)),
                  trailing: wishlist_isLoading==true?CupertinoActivityIndicator():SizedBox(
                    height: 100, width: 100,
                    child: IconButton(
                      icon: wishlist_status == true
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(Icons.favorite_border),
                      onPressed: () async{
                       await Remove_wishlist(wishlist[index]['item_id'].toString(),wishlist[index]['item_type'].toString());
                        setState(() {

                         /* Get.snackbar(
                              bookList[index].title, "Removed from wishlist");*/
                          wishlist.removeAt(index);



                        });
                      },
                    ),
                  ),
                );
              }),

    
    );
         
  }
}

class BookLists {
  String title;
  String desc;
  String imageURL;

  BookLists({required this.imageURL, required this.title, required this.desc});
}
