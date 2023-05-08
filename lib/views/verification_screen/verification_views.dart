import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/new_password_screen/new_password_view.dart';

import '../../utils/constants/heading_text_styles.dart';
import '../../utils/constants/my_colors.dart';

class VerificationCodeRoute extends StatefulWidget {
  String? otp;
   VerificationCodeRoute({super.key,required this.otp});

  @override
  VerificationCodeRouteState createState() => VerificationCodeRouteState();
}

class VerificationCodeRouteState extends State<VerificationCodeRoute> {
  TextEditingController ctrl = TextEditingController();
  TextEditingController ctr2 = TextEditingController();
  TextEditingController ctr3 = TextEditingController();
  TextEditingController ctr4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ctrl.text = "1";
    ctr2.text = "2";
    ctr3.text = "3";
    ctr4.text = "4";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("VERIFICATION",
            style: TextStyle(color: MyColors.grey_80)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MyColors.grey_80),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
          padding: const EdgeInsets.all(0.0),
          shrinkWrap: true,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(height: 30),
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset(
                              'assets/onboarding-images/img_code_verification.png'),
                        ),
                        SizedBox(
                          width: 220,
                          child: Text(
                            "OTP has been sent to you on your mobile phone. Please enter it below",
                            style: MyText.subhead(context)!
                                .copyWith(color: MyColors.grey_60),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(height: 15),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: MyText.headline(context)!.copyWith(
                                  color: MyColors.grey_90,
                                ),
                                controller: ctrl,
                              ),
                            ),
                            Container(width: 10),
                            Flexible(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: MyText.headline(context)!.copyWith(
                                  color: MyColors.grey_90,
                                ),
                                controller: ctr2,
                              ),
                            ),
                            Container(width: 10),
                            Flexible(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: MyText.headline(context)!.copyWith(
                                  color: MyColors.grey_90,
                                ),
                                controller: ctr3,
                              ),
                            ),
                            Container(width: 10),
                            Flexible(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: MyText.headline(context)!.copyWith(
                                  color: MyColors.grey_90,
                                ),
                                controller: ctr4,
                              ),
                            ),
                          ],
                        ),
                        Container(height: 30),
                        SizedBox(
                          width: 200,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.transparent),
                            child: const Text(
                              "VERIFY",
                              style: TextStyle(color: MyColors.primary),
                            ),
                            onPressed: () {
                              Get.to(const NewPasswordView());
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ]),
    );
  }
}
