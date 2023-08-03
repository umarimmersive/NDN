import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Push{

  push_noti(){
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
  }
  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    /* await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    );*/
  }

  void onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {

    print('---------------------lkcbnalcbnasnsankdsdk');
  //  showNotification();
    // display a dialog with the notification details, tap ok to go to another page
  }


 /* Future<void> showNotification() async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      //'CHANNEL_DESCRIPTION',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
   // var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android: androidChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,  // Notification ID
      'Test Title', // Notification Title
      'Test Body', // Notification Body, set as null to remove the body
      platformChannelSpecifics,
      payload: 'New Payload', // Notification Payload
    );
  }*/

}