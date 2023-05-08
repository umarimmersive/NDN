import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/constants/ColorValues.dart';
import 'package:national_digital_notes_new/utils/validator/validator.dart';
import 'package:national_digital_notes_new/views/login_screen/login_view.dart';
import 'package:national_digital_notes_new/views/sign_up_screen/signup_controller.dart';
import '../../utils/constants/Globle_data.dart';
import '../../utils/global_widgets/snackbar.dart';
import '../../utils/global_widgets/textfield_ui.dart';
import '../privacy_and_terms.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController passwordController = TextEditingController();

  // By defaut, the checkbox is unchecked and "agree" is "false"
  bool agree = false;

  final _formKey = GlobalKey<FormState>();

  SignupController signupController  = Get.put(SignupController());


  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 14.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue,fontSize: 14.0,);

    return Scaffold(
      body:
      Form(
        key: _formKey,
        child: Container(
          child: Obx(() {
            if (signupController.isLoading.value) {
              return Center(child: CupertinoActivityIndicator());
            } else {
              return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      children: <Widget>[
                        Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: Hero(
                                tag: 'LOGO',
                                child: Image.asset(
                                    'assets/onboarding-images/android_logo.png')
                            )
                        ),

                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Register with email',
                              style: TextStyle(fontSize: 20),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: MediaQuery.of(context).size.height * 0.00),
                          child: TextFieldDesigned(
                            //enableInteractiveSelection: false,
                            maxLines: 1,
                            cursorColor: ColorValues.BLACK,
                            controller: signupController.nameController,
                            validator: (value) {
                              if(value != null && value.length < 4){
                                return 'Please enter your name';
                              }else
                              return null;
                            },
                            fontSize: 14,
                            maxLength: 30,
                            minLines: 1,
                            hintText: "Name",
                            hintStyle: ColorValues.HINT_TEXT_COLOR,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            readOnly: false,
                            keyboardType: TextInputType.text,
                            prefixIcon: Icon(
                              Icons.person,
                              color:  ColorValues.HINT_TEXT_COLOR,
                              size: 16.0,
                            ),
                          ),
                        ),


                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: MediaQuery.of(context).size.height * 0.00),
                          child: TextFieldDesigned(
                            enableInteractiveSelection: false,
                            maxLines: 1,
                            cursorColor: ColorValues.BLACK,
                            controller: signupController.emailController,
                            validator: (p0)=> Validators.emailValidator(p0),
                            fontSize: 14,
                            maxLength: 50,
                            minLines: 1,
                            hintText: "Email",
                            hintStyle: ColorValues.HINT_TEXT_COLOR,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            readOnly: false,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icon(
                              Icons.mail,
                              color:  ColorValues.HINT_TEXT_COLOR,
                              size: 16.0,
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: MediaQuery.of(context).size.height * 0.00),
                          child: TextFieldDesigned(
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
                            enableInteractiveSelection: false,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            cursorColor: ColorValues.BLACK,
                            controller: signupController.mobileController,
                            validator: (value) {
                              if(value != null && value!.length < 10){
                                return 'Please fill valid mobile number.';
                              }else
                              return null;
                            },
                            maxLines: 1,
                            fontSize: 14,
                            maxLength: 13,
                            minLines: 1,
                            hintText: "Mobile",
                            hintStyle: ColorValues.HINT_TEXT_COLOR,
                            readOnly: false,
                            keyboardType: TextInputType.phone,
                            prefixIcon: Icon(
                              Icons.phone_android,
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
                                if(value != null && value!.length < 6){
                                  return 'Please Enter At Least 6 Digit Password';
                                }
                                return null;
                              },
                              cursorColor: Colors.black,
                              maxLength: 20,
                              style: TextStyle(color:  ColorValues.BLACK),
                              controller: signupController.passController,
                              obscureText: signupController.obscureNewPass.value,
                              decoration: InputDecoration(

                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:ColorValues.HINT_TEXT_COLOR,),
                                  //36325A
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorValues.BG_BT2,),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorValues.BG_BT2,),
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
                                    signupController.obscureNewPass.value =
                                    !signupController.obscureNewPass.value;
                                    setState(() {

                                    });
                                  },
                                  child: Icon(
                                    signupController.obscureNewPass.value
                                        ? Icons.lock_rounded
                                        : Icons.lock_open,
                                    size: 24,
                                    color:  ColorValues.HINT_TEXT_COLOR,
                                  ),
                                ),

                              ),
                            )
                        ),


                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.00,
                                horizontal: MediaQuery.of(context).size.height * 0.0),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              enableInteractiveSelection: false,
                              minLines: 1,
                              validator: (value) {
                                if(value != null && value!.length < 6){
                                  return 'Please Enter At Least 6 Digit Password.';
                                }
                                return null;
                              },
                              cursorColor: Colors.black,
                              maxLength: 20,
                              style: TextStyle(color: ColorValues.BLACK),
                              controller: signupController.confPassController,
                              obscureText: signupController.obscureConfPass.value,
                              decoration: InputDecoration(

                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:ColorValues.HINT_TEXT_COLOR,),
                                  //36325A
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorValues.BG_BT2,),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorValues.BG_BT2,),
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
                                  color: ColorValues.HINT_TEXT_COLOR,
                                  size: 16.0,
                                ),
                                filled: true,

                                hintText: 'Password (min 6 characters)'.tr,
                                hintStyle: TextStyle(fontSize: 14.0, color:ColorValues.HINT_TEXT_COLOR),
                                suffixIcon: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    signupController.obscureConfPass.value =
                                    !signupController.obscureConfPass.value;
                                    setState(() {

                                    });
                                  },
                                  child: Icon(
                                    signupController.obscureConfPass.value
                                        ? Icons.lock_rounded
                                        : Icons.lock_open,
                                    size: 24,
                                    color:   ColorValues.HINT_TEXT_COLOR,
                                  ),
                                ),

                              ),
                            )
                        ),



                        Column(
                            children: [
                              Row(
                                children: [
                                  Material(
                                    child: Checkbox(
                                      value: agree,
                                      onChanged: (value) {
                                        setState(() {
                                          agree = value ?? false;
                                          setState(() {

                                          });
                                        });
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: /*Text(
                                      'I have read and accept terms and conditions',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 12),
                                    ),*/
                                    RichText(
                                      text: TextSpan(
                                        style: defaultStyle,
                                        children: <TextSpan>[
                                          TextSpan(text: 'I have read and accept ', style: TextStyle(fontSize: 14),),
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
                                    )
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                      onPressed:() async {
                                        String? deviceId = await _getId();
                                        if(agree){
                                          signupController.Validation('app',device_token.toString());
                                        }else{
                                          snackbar("Please read and accept terms and conditions");
                                        }
                                       /* print('=--------------------------------------on');
                                        if (_formKey.currentState!.validate()) {
                                          print('=--------------------------------------fromm');

                                        }else{

                                        }*/
                                      },
                                      child: const Text('Register')),
                                ),
                              )
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            GestureDetector(
                              onTap: (){

                                signupController.nameController.clear();
                                signupController.emailController.clear();
                                signupController.passController.clear();
                                signupController.confPassController.clear();
                                signupController.mobileController.clear();
                                Get.to(LoginView());
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child:  Text(
                                  'Login',
                                  style: TextStyle(fontSize: 15,color: Colors.blue),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ));
            }
          }),
        ),
      )


    );
  }
  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }
}
