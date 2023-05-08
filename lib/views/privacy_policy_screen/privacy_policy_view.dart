import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/privacy_policy_screen/privacy_controller.dart';

class AboutPprPipesView extends GetView<PrivacyController> {
  const AboutPprPipesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PrivacyController());
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          controller.count.value = 0;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: controller.count.value == 0
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade300,
                              border: Border.all(color: Colors.grey)),
                          height: 55,
                          child: const Center(
                              child: Text(
                            "Terms",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, overflow: TextOverflow.fade),
                          )),
                        ),
                      )),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          controller.count.value = 1;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: controller.count.value == 1
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade300,
                              border: Border.all(color: Colors.grey)),
                          height: 55,
                          child: const Center(
                              child: Text(
                            "Privacy Policy",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, overflow: TextOverflow.fade),
                          )),
                        ),
                      )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IndexedStack(
                      index: controller.count.value,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Terms & Conditions",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                     "Website legal agreements, such as Terms and Conditions, Terms of Service, and Terms of Use, typically need to be revised and updated from time to time in order to add new provisions or adapt to new laws. Businesses need to ensure that when they update their Terms (especially when using a clickwrap agreement to do it,",
                                    style: TextStyle(
                                        overflow: TextOverflow.fade,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey.shade500),
                                  )),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Privacy Polices",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "A Privacy Policy is a statement or a legal document that states how a company or website collects, handles and processes data of its customers and visitors. It explicitly describes whether that information is kept confidential, or is shared with or sold to third parties.",
                                    style: TextStyle(
                                        overflow: TextOverflow.fade,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey.shade500),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
