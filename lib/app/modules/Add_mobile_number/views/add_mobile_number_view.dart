import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/constants/ColorValues.dart';
import '../../../../utils/constants/heading_text_styles.dart';
import '../../../../utils/global_widgets/textfield_ui.dart';
import '../controllers/add_mobile_number_controller.dart';

class AddMobileNumberView extends GetView<AddMobileNumberController> {
   AddMobileNumberView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

 // Login_controller Controller  = Get.put(Login_controller());


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
                        child: Text("Verify Mobile Number",
                            style: TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      Container(height: 5),
                      Center(
                        child: Text("",
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
                          //validator: (p0)=> Validators.emailValidator(p0),
                          fontSize: 14,
                          maxLength: 50,
                          minLines: 1,
                          hintText: "Mobile",
                          hintStyle: ColorValues.HINT_TEXT_COLOR,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: false,
                          keyboardType: TextInputType.number,
                          prefixIcon: Icon(
                            Icons.phone,
                            color:  ColorValues.HINT_TEXT_COLOR,
                            size: 16.0,
                          ),
                        ),
                      ),






                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, elevation: 0),
                          child: const Text("Submit", style: TextStyle(color: Colors.white)),
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


                    ]),
                  );
              }
            }),
          ),
        )


    );
  }
}
