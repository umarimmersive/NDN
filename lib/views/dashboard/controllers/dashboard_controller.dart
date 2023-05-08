import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../dashboard_screen/controller_home_view.dart';

class DashboardController extends GetxController {


  final currentIndex = 0.obs;
  final item = [].obs;
  final advertisementList = <String>[].obs;
  final categoryList_all = [].obs;
  final package_id = 0.obs;
  final bar_title = "".obs;

  final baseUrl_category = "".obs;
  final baseUrl_advertisement = "".obs;
  final baseUrl_event = "".obs;
  final username = "".obs;
  final count = 0.obs;
  final current = 0.obs;
  final bool_isLogin = false.obs;

  String token = "";
  late SharedPreferences prefs;

  final persistentTabController = PersistentTabController();
  bool hideNavBar = false;

  final home_controller = Get.put(controller_home_view());

  late final FirebaseMessaging _messaging;


  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {





      print('User granted permission');


      // TODO: handle the received notifications
    } else {
      print('User declined or has not accepted permission');
    }



  }










  @override
  void onInit() {
    super.onInit();






    registerNotification();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      //print('getInitialMessage => display: ${message?.notification?.title}');
      // print('display: ${message?.notification?.body}');
      print('display: ${message?.data.toString()}');
      if (message != null) {
       // LocalNotificationService.display(message);
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      print('onMessage => display: ${message.notification?.title}');
      print('display: ${message.notification?.body}');
      print('display: ${message.data.toString()}');
      //LocalNotificationService.display(message);
    });

    //app open
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("onMessageOpenedApp" + message.toString());
      print('onMessageOpenedApp => display: ${message.notification?.title}');
      print('display: ${message.notification?.body}');
      print('display: ${message.data.toString()}');
     // LocalNotificationService.display(message);
    });

    hideNavBar = false;
    home_controller.onInit();


  }

  @override
  void onClose() {
    home_controller.onClose();

  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add),
        title: ("Add"),
        activeColorPrimary: Colors.blueAccent,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: Colors.white,
        /* routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: '/',
            routes: {
              '/first': (context) => MainScreen2(),
              '/second': (context) => MainScreen3(),
            },
          ),
          onPressed: (context) {
            pushDynamicScreen(context,
                screen: SampleModalScreen(), withNavBar: true);
          }*/
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message),
        title: ("Messages"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
        /* routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => MainScreen2(),
            '/second': (context) => MainScreen3(),
          },
        ),*/
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        /*routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => MainScreen2(),
            '/second': (context) => MainScreen3(),
          },
        ),*/
      ),
    ];

    void increment() => count.value++;
  }
}
