import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:national_digital_notes_new/views/login_screen/login_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/constants/api_service.dart';
import '../../utils/constants/heading_text_styles.dart';
import '../../utils/constants/my_colors.dart';
import '../../utils/global_widgets/snackbar.dart';
import '../dashboard/views/dashboard_view.dart';
import '../dashboard_screen/Home_view.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({Key? key}) : super(key: key);

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  bool isVisible1 = false;
  bool isVisible2 = false;
  TextEditingController newPassword = TextEditingController();
  TextEditingController ConfirmPassword = TextEditingController();

  final isLoading=false.obs;

  final id='';
  Set_new_password() async {
    try {

      isLoading(true);
         setState(() {

           });




      var response = await ApiService()
          .Set_new_pass(userData!.userId,newPassword.text,ConfirmPassword.text);
      print({'========================$response'});

      if (response['success'] == true) {

        snackbar(response['message'].toString());

        //Get.snackbar('Message',response['message'].toString());

        Get.to(DashboardView());
        isLoading(false);

        setState(() {

        });

      } else if (response['success'] == false) {

        snackbar(response['message'].toString());
        setState(() {

        });
        //Get.snackbar('Message',response['message'].toString());

      }

    } finally {
      isLoading(false);
      setState(() {

      });

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), child: Container()),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        width: double.infinity,
        height: double.infinity,
        child: ListView(children: [
          Center(
            child: Container(
              alignment: Alignment.topLeft,
              width: 80,
              height: 80,
              child: Hero(
                  tag: 'LOGO',
                  child:
                      Image.asset('assets/onboarding-images/android_logo.png')),
            ),
          ),
          Container(height: 10),
          Center(
            child: Text("Set New Password",
                style: MyText.title(context)!.copyWith(
                    color: MyColors.grey_80, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: newPassword,
                obscureText: !isVisible1,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible1 = !isVisible1;
                      });
                    },
                    icon: isVisible1
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: 'New Password',
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: ConfirmPassword,
                obscureText: !isVisible2,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible2 = !isVisible2;
                      });
                    },
                    icon: isVisible2
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: 'Confirm Password',
                ),
              ),
            ),
          ),
          Container(height: 5),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent[400], elevation: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[


                Text("Submit", style: TextStyle(color: Colors.white)),
                isLoading==true?
                Padding(padding: EdgeInsets.only(left: 10),
                child: CupertinoActivityIndicator(),
                ):
                    SizedBox()
              ],)
                  ,
              onPressed: () async{
              //  Get.offAll( LoginView());
               await Set_new_password();
              },
            ),
          ),
        ]),
      ),
    );
  }
}
