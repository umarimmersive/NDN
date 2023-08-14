import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:national_digital_notes_new/utils/routes/app_pages.dart';
import 'package:path_provider/path_provider.dart';
import '../../main.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission for notifications (iOS only)
    await _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      provisional: false,
    );
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ndn_logo');

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();


    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings('ndn_logo'),
        iOS: DarwinInitializationSettings(
          defaultPresentAlert: true,
          defaultPresentBadge: true,
          defaultPresentBanner: true,
          defaultPresentSound: true,
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        )
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings, onDidReceiveNotificationResponse: (payload) {
      print('-------------------------noti');
      print('payload-------------------------${payload.payload}');
      switch(payload.payload){
        /*case "1":
          Get.toNamed(Routes.NOTICATION);
          break;
        case "2":
          var data={
            "index":"1"
          };
          Get.toNamed(Routes.HOME,parameters: data);*/
      }
    },

    );


    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get the device token
    String? token = await _firebaseMessaging.getToken();
    print('Device Token: $token');

    // Handle incoming notifications when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
      _showNotificationCustomSound(message);
    });

    // Handle notification when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _showNotification(message);
      _showNotificationCustomSound(message);
    });

  }
  Future<void> _showNotificationCustomSound(message) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        channelDescription: 'your other channel description',
        sound: RawResourceAndroidNotificationSound('default'),
        playSound: true,
        icon: "ndn_logo"
    );
    const DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
      sound: 'besttune',
    );
    final LinuxNotificationDetails linuxPlatformChannelSpecifics =
    LinuxNotificationDetails(
      sound: AssetsLinuxSound('sound/slow_spring_board.mp3'),
    );
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
      macOS: darwinNotificationDetails,
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      id++,
      '${message.notification?.title ?? ''}',
      '${message.notification?.body ?? ''}',
      notificationDetails,
    );
  }
  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> _showNotification(message) async {


    print('--------------------------${ message.data}');

    if(message.data['image'].toString().isNotEmpty){

      print('image-------------------------------');

      final String largeIconPath =
      await _downloadAndSaveFile(message.data['image'].toString(), 'largeIcon');
      final String bigPicturePath = await _downloadAndSaveFile(
          message.data['image'].toString(), 'bigPicture');
      final BigPictureStyleInformation bigPictureStyleInformation =
      BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
          largeIcon: FilePathAndroidBitmap(largeIconPath),
          contentTitle: message.notification?.title,
          htmlFormatContentTitle: true,
          summaryText:  message.notification?.body,
          htmlFormatSummaryText: true);


      AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          styleInformation: bigPictureStyleInformation,
          importance: Importance.max,

          priority: Priority.high,
          enableVibration: true,
          ticker: 'ticker');
      NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
          id++,  message.notification?.title ?? '',
          message.notification?.body?? '', notificationDetails,
          payload: message.data['notify_type'].toString());
    }else{
      print('text-------------------------------');
      AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          //styleInformation: bigPictureStyleInformation,
          importance: Importance.max,

          priority: Priority.high,
          enableVibration: true,
          ticker: 'ticker');
      NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
          id++,  message.notification?.title ?? '',
          message.notification?.body?? '', notificationDetails,
          payload: message.data['notify_type'].toString());
    }

  }



}

