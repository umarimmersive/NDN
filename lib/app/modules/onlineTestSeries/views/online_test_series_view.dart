import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/routes/app_pages.dart';
import '../controllers/online_test_series_controller.dart';

class OnlineTestSeriesView extends GetView<OnlineTestSeriesController> {
  const OnlineTestSeriesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Test Series'),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: controller.examTestSeriesData.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
             /* var data={
                'Series_name':controller.examTestSeriesData[index].
              };*/
              Get.toNamed(Routes.TEST_LIST);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 00.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.examTestSeriesData[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        controller.examTest[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
