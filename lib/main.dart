import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:national_digital_notes_new/utils/constants/Globle_data.dart';
import 'package:national_digital_notes_new/utils/routes/app_pages.dart';

import 'Push.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Get_token(){
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print('device_token =  $value');
      device_token = value;
      print('token----------------------------------$device_token');
      }
    );
  }


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);


  await Get_token();


  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);





  Push().push_noti();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  HttpOverrides.global = MyHttpOverrides();
  //Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      defaultTransition: Transition.fadeIn,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins-Regular',
        primarySwatch: Colors.blue,
      ),
     // home: AppSplashScreen(),
    );
  }
}
