import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/login_screen/login_view.dart';

import '../../utils/constants/heading_text_styles.dart';
import '../../utils/constants/my_colors.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({Key? key}) : super(key: key);

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  bool isVisible1 = false;
  bool isVisible2 = false;

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
              child:
                  const Text("Submit", style: TextStyle(color: Colors.white)),
              onPressed: () {
                Get.offAll( LoginView());
              },
            ),
          ),
        ]),
      ),
    );
  }
}
