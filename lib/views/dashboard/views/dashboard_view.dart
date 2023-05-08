import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/dashboard_screen/Home_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../utils/constants/api_service.dart';
import '../../add_to_cart_screen/add_to_cart_view.dart';
import '../../inshort/inshort.dart';
import '../../my_library_screen/my_library_screen.dart';
import '../../notification_screen/notification_screen.dart';
import '../../profile_settings_screen/profile_settings_views.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  final _currentIndex = 0.obs;


 // final controller = Get.find<DashboardController>();

  Future<bool> pop() async {
    Navigator.pop(ApiService.context);
    return true;
  }



  Future<bool?> _onBackPressed(context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            backgroundColor: Colors.blue,
            title:
            Padding(padding: EdgeInsets.only(top: 20),child:  Center(
              child:
              Text('Do You Want To Exit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Lato',
                ),
              ),

              //Text('Do you want to exit ',),
            ),),


            content:
            Text(''),
            actionsAlignment: MainAxisAlignment.spaceEvenly,

            actions: <Widget>[
              Padding(padding: EdgeInsets.only(bottom: 20),child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  child: Text(
                    'NO',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Lato',
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ),),
              Padding(padding: EdgeInsets.only(bottom: 20),child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  child: Text(
                    'YES',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Lato',
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    SystemNavigator.pop();
                  },
                ),
              ),),


            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
      //ApiService.context = context;
    return  WillPopScope(
      child:Obx(() => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: BottomNavigationBar(
              showUnselectedLabels: false,
              currentIndex: _currentIndex.value,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.blue,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(.60),
              selectedFontSize: 11,
              unselectedFontSize: 11,
              onTap: (value) {
                _currentIndex.value = value;
                // Respond to item press.
              },
              items: [
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  label: "Library",
                  icon: Icon(Icons.school),
                ),
                BottomNavigationBarItem(
                  label: "News",
                  icon: Icon(Icons.book),
                ),
                BottomNavigationBarItem(
                  label: "Profile",
                  icon: Icon(Icons.person),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
          /*  Obx(() => SizedBox(
              height: controller.count.value.toDouble(),
            )),*/
            buildScreens[_currentIndex.value]
          ],
        ),
      )),
      onWillPop: () async {
        bool? result= await _onBackPressed(context);
        if(result == null){
          result = false;
        }
        return result;
      },

    );
  }

  AppBar buildAppBar(BuildContext context) {
    return  AppBar(
      leading: IconButton(
        onPressed: () {
          //_scaffoldKey.currentState?.openDrawer();
         // log("Tapped on Drawer");
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
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(const NotificationScreen());
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
              ),
              /* IconButton(
                        onPressed: () {

                        },
                        icon: const Icon(Icons.shopping_cart))*/
              IconButton(
                onPressed: () {
                  //Get.to(const SettingProfileRoute());
                  Get.to(const AddToCartView());
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  List buildScreens = <Widget>[
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
   // Screen5(),
  ].obs;
}


Widget Screen1() {
  return Home_view();
}

Widget Screen2() {
  return MyLibraryView();
}

Widget Screen3() {
  return InShort();
}

Widget Screen4() {
  return SettingProfileRoute();
}
