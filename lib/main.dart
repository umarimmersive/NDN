import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:national_digital_notes_new/utils/constants/Globle_data.dart';
import 'package:national_digital_notes_new/utils/routes/app_pages.dart';
import 'package:national_digital_notes_new/views/main/screens/AppSplashScreen.dart';

// AppStore appStore = AppStore();

Future<void> backgroundHandler(RemoteMessage message) async {

  print("==========${message.data.toString()}");
  print("==========${message.notification!.body.toString()}");
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
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await  Get_token();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
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
