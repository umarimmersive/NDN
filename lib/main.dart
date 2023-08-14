import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:national_digital_notes_new/utils/constants/Globle_data.dart';
import 'package:national_digital_notes_new/utils/routes/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Push.dart';
int id = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const String darwinNotificationCategoryPlain = 'plainCategory';

String? selectedNotificationPayload;
Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}



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
const String darwinNotificationCategoryText = 'textCategory';
const String navigationActionId = 'id_3';


Future downloadFile() async {
  if (await Permission.storage.request().isGranted) {
    print("--------------------main permisstion");
   // await startDownload(book_path);
  } else {
    //await startDownload(book_path);
  }
}
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await downloadFile();
  await Firebase.initializeApp();
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);


  await Get_token();


  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
      Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  // String initialRoute = HomePage.routeName;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload =
        notificationAppLaunchDetails!.notificationResponse?.payload;
    //  initialRoute = SecondPage.routeName;
  }

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('ndn_logo');

  final List<DarwinNotificationCategory> darwinNotificationCategories =
  <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];







  await PushNotificationService().initialize();
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
      title: 'NDN',
      theme: ThemeData(
        fontFamily: 'Poppins-Regular',
        primarySwatch: Colors.blue,
      ),
     // home: AppSplashScreen(),
    );
  }
}
