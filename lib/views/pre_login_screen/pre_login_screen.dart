import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:national_digital_notes_new/views/login_screen/login_view.dart';
import 'package:national_digital_notes_new/views/privacy_and_terms.dart';

import '../../utils/global_widgets/google_login/authentication.dart';
import '../pre_signin_screen/pre_signin_view.dart';
import '../sign_up_screen/signup_controller.dart';
import '../sign_up_screen/signup_view.dart';

class PreLoginScreen extends StatelessWidget {
   PreLoginScreen({Key? key}) : super(key: key);

  Widget _buildImage() {
    return Image.asset(
      'assets/onboarding-images/android_logo.png',
      fit: BoxFit.fill,
    );
  }

  bool isSignIn =false;
  bool google =false;
   SignupController signupController  = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 14.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue,fontSize: 14.0,);
    var kH = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Hero(tag: 'LOGO', child: _buildImage()),
            ),
          ),
          SizedBox(
            height: kH * 0.02,
          ),
          const Text(
            "Register to use NDN",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: kH * 0.02,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              onTap: () {
                //GoogleSignInButton();
                signupController.onGoogleLogin();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                height: 40,
                child: Row(
                  children: [
                    Image.asset(
                        'assets/social_logo/google-logo-history-png-2603.png'),
                    const Spacer(),
                    const Text(
                      "Register with Google",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(
            height: kH * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              onTap: () {
                Get.to( SignupView());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                height: 40,
                child: Row(
                  children: [
                    Image.asset('assets/social_logo/email-logo-png-1111.png'),
                    const Spacer(),
                    const Text(
                      "Register with Email",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: kH * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(fontSize: 14),
              ),
              TextButton(
                  onPressed: () {
                    Get.to( LoginView());
                  },
                  child: const Text(
                    "Login in here",
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  )),
            ],
          ),
          SizedBox(
            height: kH * 0.02,
          ),


      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: RichText(
            text: TextSpan(
              style: defaultStyle,
              children: <TextSpan>[
                TextSpan(text: 'By clicking here, I state that I have read and understood the', style: TextStyle(fontSize: 14),),
                TextSpan(
                    text: ' Terms and conditions',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(TermsScreen());
                        print('======saSasa=====Terms of Service"');
                      }),
                TextSpan(text: '', style: TextStyle(fontSize: 14),),
                TextSpan(
                    text: '',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Privacy Policy"',);
                      }),
              ],
            ),
          ),
        ),
      ),
         /* const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "By clicking here, I state that I have read and understood the terms and conditions.",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),*/
          SizedBox(
            height: kH * 0.02,
          ),
        ],
      ),
    );
  }
}
