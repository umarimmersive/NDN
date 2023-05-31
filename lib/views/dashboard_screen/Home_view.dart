import 'dart:convert';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/constants/api_service.dart';
import 'package:national_digital_notes_new/utils/constants/my_local_service.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:national_digital_notes_new/utils/routes/app_pages.dart';
import 'package:national_digital_notes_new/views/about_screen/about_us_view.dart';
import 'package:national_digital_notes_new/views/inshort/inshort.dart';
import 'package:national_digital_notes_new/views/notification_screen/notification_screen.dart';
import 'package:national_digital_notes_new/views/pre_login_screen/pre_login_screen.dart';
import 'package:national_digital_notes_new/views/sucess_story_screens/success_story_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/constants/Globle_data.dart';
import '../../utils/constants/heading_text_styles.dart';
import '../../utils/constants/my_colors.dart';
import '../add_to_cart_screen/add_to_cart_view.dart';
import '../detailed_course_screen/detailed_course_view.dart';
import '../my_library_screen/my_library_screen.dart';
import '../privacy_and_terms.dart';
import '../profile_settings_screen/profile_settings_views.dart';
import '../wishlists/wishlists.dart';
import 'controller_home_view.dart';
import 'package:http/http.dart' as http;

/*
class Home_view extends StatefulWidget {
  const Home_view({Key? key}) : super(key: key);
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<Home_view> createState() => _Home_viewState();
}
*/

class Home_view extends GetView<controller_home_view> {

// _onShare method:

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("Logout"),
      onPressed: () async {

        my_local_service.logout();

      },
    );
    Widget noButton = ElevatedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Do you want to exit this application?"),
      content: const Text("We hate to see you leave..."),
      actions: [
        noButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

 /* int _selectedIndex = 0;

  void _onItemTapped(int index) async{
    if (index == 1) {
     await Get.to( MyLibraryView());
    }
    if (index == 2) {
     await Get.to(InShort());
    }
    if (index == 3) {
      _scaffoldKey.currentState?.openDrawer();
      _selectedIndex = 0;
      index = 0;
    }

    setState(() {
      _selectedIndex = index;
    });
  }
*/



/*

  DashboardController dashboardController = Get.put(DashboardController());


  final List<IconData> iconData = <IconData>[
    Icons.book,
    Icons.school,
    Icons.ac_unit_rounded,
    Icons.access_alarm_outlined,
    Icons.class_,
    Icons.book,
    Icons.school,
    Icons.ac_unit_rounded,
    Icons.access_alarm_outlined,
    Icons.class_,
    Icons.confirmation_num_sharp,
    Icons.confirmation_num_sharp,
  ];
*/
  controller_home_view home_controller = Get.put(controller_home_view());
  final List<IconData> iconData = <IconData>[
    Icons.book,
    Icons.school,
    Icons.ac_unit_rounded,
    Icons.access_alarm_outlined,
    Icons.class_,
    Icons.book,
    Icons.school,
    Icons.ac_unit_rounded,
    Icons.access_alarm_outlined,
    Icons.class_,
    Icons.confirmation_num_sharp,
    Icons.confirmation_num_sharp,
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  String messageTitle = "Empty";
  String notificationAlert = "alert";

  late FirebaseMessaging messaging;

  RxList mainSliderImg = [].obs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: SingleChildScrollView(
              child:

              Column(
                children: <Widget>[

                  GestureDetector(
                    onTap: () async{
                      print("===========");
                      await Get.to(SettingProfileRoute(backButton: false,));
                      // Navigator.pop(context);
                      //Get.back();
                    },
                    child: SizedBox(
                      height: 190,
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            'assets/home_screen_images/material_bg_1.png',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          userData!.profileImage!="null"?
                         Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 40, horizontal: 14),
                          child: CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.grey[100],
                            child:  CircleAvatar(
                              radius: 33,
                              backgroundImage: NetworkImage(ApiService.IMAGE_URL+userData!.profileImage),
                            ),
                          ),
                        )
                        :
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 14),
                            child: CircleAvatar(
                              radius: 36,
                              backgroundColor: Colors.grey[100],
                              child: CircleAvatar(
                                radius: 33,
                                backgroundImage: AssetImage('assets/profile.png'),
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("${userData!.name}",
                                      style: MyText.body2(context)!.copyWith(
                                          color: Colors.grey[100],
                                          fontWeight: FontWeight.bold)),
                                  Container(height: 5),
                                  Text("${userData!.emailId}",
                                      style: MyText.body2(context)!
                                          .copyWith(color: Colors.grey[100]))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ListTile(
                    title: Text("My Library",
                        style: MyText.subhead(context)!
                            .copyWith(fontWeight: FontWeight.w500)),
                    leading: const Icon(Icons.subscriptions,
                        size: 25.0, color: Colors.grey),
                    onTap: () {
                      Get.to(const MyLibraryView());
                      // onDrawerItemClicked("Home");
                    },
                  ),

                  ListTile(
                    title: Text("News",
                        style: MyText.subhead(context)!
                            .copyWith(fontWeight: FontWeight.w500)),
                    leading: const Icon(Icons.menu_book_sharp,
                        size: 25.0, color: Colors.grey),
                    onTap: () {
                      Get.to(InShort());
                      // onDrawerItemClicked("Latest");
                    },
                  ),

                  const Divider(
                    height: 1,
                    thickness: 1.4,
                  ),

                  ListTile(
                    title: Text("Wishlist",
                        style: MyText.subhead(context)!
                            .copyWith(fontWeight: FontWeight.w500)),
                    leading:
                    const Icon(Icons.favorite, size: 25.0, color: Colors.grey),
                    onTap: () {
                      Get.to(const Wishlists());
                      // onDrawerItemClicked("Highlight");
                    },
                  ),

                  // ListTile(
                  //   title: Text("Current Affairs",
                  //       style: MyText.subhead(context)!.copyWith(
                  //           color: Colors.black, fontWeight: FontWeight.w500)),
                  //   leading:
                  //       const Icon(Icons.newspaper, size: 25.0, color: Colors.grey),
                  //   onTap: () {
                  //     // onDrawerItemClicked("Settings");
                  //   },
                  // ),
                  ListTile(
                    title: Text("Success Stories",
                        style: MyText.subhead(context)!
                            .copyWith(fontWeight: FontWeight.w500)),
                    leading: const Icon(Icons.auto_stories,
                        size: 25.0, color: Colors.grey),
                    onTap: () {
                      Get.to(const SuccessStory());
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1.4,
                  ),

                  ListTile(
                    title: Text("Share",
                        style: MyText.subhead(context)!
                            .copyWith(fontWeight: FontWeight.w500)),
                    leading:
                    const Icon(Icons.share, size: 25.0, color: Colors.grey),
                    onTap: () async {
                      final box = context.findRenderObject() as RenderBox?;

                      await Share.share(
                        "hello guys",
                        subject: "",
                        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                      );
                      // Share.text(
                      //   'NATIONAL DIGITAL NOTES',
                      //   'NDN',
                      //   'www.google.com',
                      // );
                      // onDrawerItemClicked("Help");
                    },
                  ),

                  const Divider(
                    height: 1,
                    thickness: 1.4,
                  ),
                  ListTile(
                    title: Text("Contact us",
                        style: MyText.subhead(context)!
                            .copyWith(fontWeight: FontWeight.w500)),
                    leading:
                    const Icon(Icons.phone, size: 25.0, color: Colors.grey),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => const CustomEventDialog());
                      // onDrawerItemClicked("Help");
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1.4,
                  ),
                  ListTile(
                    title: Text("About NDN",
                        style: MyText.subhead(context)!
                            .copyWith(fontWeight: FontWeight.w500)),
                    leading: const Icon(Icons.info, size: 25.0, color: Colors.grey),
                    onTap: () {
                      Get.to(const AboutAppSimpleBlueRoute());
                      // onDrawerItemClicked("Help");
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1.4,
                  ),
                  ListTile(
                    title: Text("Terms",
                        style: MyText.subhead(context)!
                            .copyWith(fontWeight: FontWeight.w500)),
                    leading: const Icon(Icons.front_hand_sharp,
                        size: 25.0, color: Colors.grey),
                    onTap: () {
                      Get.to(const TermsScreen());
                      // onDrawerItemClicked("Help");
                    },
                  ),
                  ListTile(
                    title: Text("Polices",
                        style: MyText.subhead(context)!
                            .copyWith(fontWeight: FontWeight.w500)),
                    leading:
                    const Icon(Icons.policy, size: 25.0, color: Colors.grey),
                    onTap: () {
                      Get.to(const PoliciesScreen());

                      // onDrawerItemClicked("Help");
                    },
                  ),
                  ListTile(
                    title: Text("Logout",
                        style: MyText.subhead(context)!
                            .copyWith(fontWeight: FontWeight.w500)),
                    leading: const Icon(Icons.help_outline,
                        size: 25.0, color: Colors.grey),
                    onTap: () {
                      showDialog(
                          context: context, builder: showAlertDialog(context));
                      // Get.offAll(const LoginView());
                    },
                  ),
                ],
              )
          ),
        ),
        key: _scaffoldKey,
        backgroundColor: Colors.blue.shade50,


        appBar: AppBar(
          actions: <Widget>[

            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              onPressed: () {
                Get.to(const NotificationScreen());
                // do something
              },
            ),


            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {
                Get.to(const AddToCartView());
                // do something
              },
            ),

          ],
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
              log("Tapped on Drawer");
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 2,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Dashboard",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),

            ],
          ),
        ),


        body: Obx((){
          if(home_controller.examCategoriesMap.isEmpty){
            return Center(child: CupertinoActivityIndicator());
          }else{
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        height: 150,
                        viewportFraction: 0.99,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: home_controller.mainSliderImg.map((img) {
                        print("==========image");
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width * 0.99,
                                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: CachedNetworkImage(
                                  imageUrl:'${ApiService.IMAGE_URL+img}',fit: BoxFit.fill,));
                          },
                        );
                      }).toList(),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top: 10,left: 5),
                    child: Text(
                      "EXAMS CATEGORIES",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          letterSpacing: 1.05,
                          fontWeight: FontWeight.w600),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        primary: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 2,
                            crossAxisCount: 2,
                            childAspectRatio: 1.2),
                        itemCount:
                        home_controller.examCategoriesMap['data'].length ?? 1,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () async{
                              home_controller.examCategories.value =
                                  home_controller.examCategoriesMap['data'][index]['name'].toString();

                              home_controller.examCategories.value =
                                  home_controller.examCategoriesMap['data'][index]['name'].toString();


                              /*  await  Get.to(
                                TabsSimpleLightRoute(
                                  title: home_controller.examCategoriesMap['data'][index]['name'].toString(),
                                  id: home_controller.examCategoriesMap['data'][index]['id'].toString(),
                                ));*/


                              var data={
                                "title":"${home_controller.examCategoriesMap['data'][index]['name'].toString()}",
                                "id":"${home_controller.examCategoriesMap['data'][index]['id'].toString()}"
                              };


                              Get.toNamed(Routes.COURSE_DETAILS,parameters: data);


                              log(home_controller.examCategories.value);
                            },
                            child: Obx(
                                  () => Card(
                                elevation: 10,
                                color: Colors.white,
                                child: Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  color: Colors.transparent,
                                  alignment: Alignment.bottomRight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 60,
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10, bottom: 0),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${home_controller.examCategoriesMap['data'][index]['name']}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(
                                        height: 4,
                                        thickness: 1.3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Flexible(
                                                child: Text(
                                                  home_controller.examCategoriesMap['data'][index]['description'].toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ') ?? '',
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: TextStyle(fontSize: 12,color: Colors.black),
                                                )),
                                            Flexible(

                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color((math.Random()
                                                          .nextDouble() *
                                                          0xFFFFFF)
                                                          .toInt())
                                                          .withOpacity(0.4)),
                                                  width: 40,
                                                  height: 40,
                                                  child: Icon(iconData[index])),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ]);
          }
        }

        ),
      );

  }
}

class CustomEventDialog extends StatefulWidget {
  const CustomEventDialog({Key? key}) : super(key: key);

  @override
  CustomEventDialogState createState() => CustomEventDialogState();
}

class CustomEventDialogState extends State<CustomEventDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 160,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Wrap(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                color: Colors.lightGreen[400],
                child: Column(
                  children: <Widget>[
                    Container(height: 10),
                    const Icon(Icons.call, color: Colors.white, size: 80),
                    Container(height: 10),
                    Text("Contact us",
                        style: MyText.title(context)!
                            .copyWith(color: Colors.white)),
                    Container(height: 10),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Text('+91 ${Context_number}',
                        textAlign: TextAlign.center,
                        style: MyText.subhead(context)!
                            .copyWith(color: MyColors.grey_60)),
                    Container(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen[500],
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                      ),
                      child: const Text("Call Now",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        // ignore: deprecated_member_use
                        launch("tel://+91 ${Context_number}");
                      },
                    ),
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
