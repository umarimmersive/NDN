import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/dashboard_screen/Home_view.dart';
import 'package:national_digital_notes_new/views/forgot_screen/forgot_view.dart';
import 'package:national_digital_notes_new/views/login_screen/login_controller.dart';
import 'package:national_digital_notes_new/views/pre_login_screen/pre_login_screen.dart';
import 'package:national_digital_notes_new/views/sign_up_screen/signup_view.dart';
import '../../utils/constants/ColorValues.dart';
import '../../utils/constants/heading_text_styles.dart';
import '../../utils/global_widgets/textfield_ui.dart';
import '../../utils/validator/validator.dart';

class LoginView extends GetView<Login_controller> {

  final _formKey = GlobalKey<FormState>();

  Login_controller Controller  = Get.put(Login_controller());


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
                    Container(height: 15),
                    const Center(
                      child: Text("Welcome To The Login",
                          style: TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Container(height: 5),
                    Center(
                      child: Text("Login to continue",
                          style: MyText.subhead(context)!.copyWith(
                              color: Colors.blueGrey[300], fontWeight: FontWeight.bold)),
                    ),
                    Container(height: 50),


                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: MediaQuery.of(context).size.height * 0.00),
                      child: TextFieldDesigned(
                        enableInteractiveSelection: false,
                        maxLines: 1,
                        cursorColor: ColorValues.BLACK,
                        controller: controller.emailController,
                        validator: (p0)=> Validators.emailValidator(p0),
                        fontSize: 14,
                        maxLength: 50,
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



                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.00,
                            horizontal: MediaQuery.of(context).size.height * 0.00),
                        child: TextFormField(
                          enableInteractiveSelection: false,
                          maxLines: 1,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value != null && value.length < 6) {
                              return 'Invalid Password.';
                            }
                            return null;
                          },
                          cursorColor: Colors.black,
                          maxLength: 20,
                          style: TextStyle(color:  ColorValues.BLACK),
                          controller: controller.passController,
                          obscureText: controller.obscureNewPass.value,
                          decoration: InputDecoration(

                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:ColorValues.HINT_TEXT_COLOR,),
                              //36325A
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorValues.HINT_TEXT_COLOR,),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorValues.HINT_TEXT_COLOR,),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorValues.BORDER_COLORE,),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color:  ColorValues.HINT_TEXT_COLOR,
                              size: 16.0,
                            ),
                            filled: true,

                            hintText: 'Password (min 6 characters)'.tr,
                            hintStyle: TextStyle(fontSize: 14.0, color:ColorValues.HINT_TEXT_COLOR),
                            suffixIcon: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                controller.obscureNewPass.value =
                                !controller.obscureNewPass.value;
                              },
                              child: Icon(
                                controller.obscureNewPass.value
                                    ? Icons.lock_rounded
                                    : Icons.lock_open,
                                size: 24,
                                color:  ColorValues.HINT_TEXT_COLOR,
                              ),
                            ),

                          ),
                        )
                    ),

                    Row(
                      children: <Widget>[
                        const Spacer(),
                        TextButton(
                          style:
                          TextButton.styleFrom(foregroundColor: Colors.transparent),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.blue[400]),
                          ),
                          onPressed: () {
                            Get.to( ForgotScreen());
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, elevation: 0),
                        child: const Text("Login", style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          /*if (_formKey.currentState!.validate()) {
                            // TODO submit

                          }*/
                          controller.Validation();
                          // Get.to(const DashboardView());
                          //_doSomething();
                        },
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Get.to( PreLoginScreen());
                          },
                          child: Container(
                            child: Text("New user?",
                                style: TextStyle(color: ColorValues.HINT_TEXT_COLOR)),
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            controller.emailController.clear();
                            controller.passController.clear();

                             Get.to(SignupView());
                          },
                          child:Container(
                            margin: EdgeInsets.only(left: 05),
                            child: Text("Sign up",
                                style: TextStyle(color: ColorValues.BORDER_COLORE)),
                          )
                        ),
                    ],
                    )
                  ]),
                );
            }
          }),
        ),
      )


    );
  }
}
