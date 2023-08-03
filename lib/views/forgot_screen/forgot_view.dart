import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/forgot_screen/forgot_password.dart';
import 'package:national_digital_notes_new/views/verification_screen/verification_views.dart';

import '../../utils/constants/ColorValues.dart';
import '../../utils/constants/heading_text_styles.dart';
import '../../utils/constants/my_colors.dart';
import '../../utils/global_widgets/textfield_ui.dart';
import '../../utils/validator/validator.dart';

class ForgotScreen extends StatelessWidget {
   ForgotScreen({Key? key}) : super(key: key);
  forgot_password_controller controller  = Get.put(forgot_password_controller());

   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), child: Container()),
      body:
      Form(
        key: _formKey,
        child: Container(
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CupertinoActivityIndicator());
            } else {
              return
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(height: 30),
                      Center(
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Hero(
                              tag: 'LOGO',
                              child: Image.asset(
                                  'assets/onboarding-images/android_logo.png')),
                        ),
                      ),
                      Container(height: 15),
                      Center(
                        child: Text("Forgot Password",
                            style: MyText.title(context)!.copyWith(
                                color: MyColors.grey_80, fontWeight: FontWeight.bold)),
                      ),
                      Container(height: 5),
                      Center(
                        child: Text("Enter mail to continue",
                            style: MyText.subhead(context)!.copyWith(
                                color: Colors.blueGrey[300],
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      /* Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: const SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
              ),*/
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: MediaQuery.of(context).size.height * 0.00),
                        child: TextFieldDesigned(
                          enableInteractiveSelection: false,
                          cursorColor: ColorValues.BLACK,
                          controller: controller.emailController,
                          validator: (p0)=> Validators.emailValidator(p0),
                          maxLines: 1,
                          fontSize: 14,
                          maxLength: 40,
                          minLines: 1,
                          hintText: "Email",
                          hintStyle: ColorValues.HINT_TEXT_COLOR,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: false,
                          keyboardType: TextInputType.text,
                          prefixIcon: Icon(
                            Icons.mail,
                            color:  ColorValues.HINT_TEXT_COLOR,
                            size: 16.0,
                          ),
                        ),
                      ),

                      Container(height: 5),



                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, elevation: 0),
                          child: const Text("Continue",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            /*if (_formKey.currentState!.validate()) {
                              // TODO submit

                            }*/
                            controller.Validation();
                            /* Get.to(const VerificationCodeRoute());*/
                          },
                        ),
                      ),
                    ],
                  ),
                );
            }
          }),
        ),
      )


    );
  }
}
