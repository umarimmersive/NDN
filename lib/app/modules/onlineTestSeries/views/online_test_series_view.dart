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
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: controller.examTestSeriesData.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              child: ListTile(
                title: Text(
                  controller.examTestSeriesData[index],
                  style: TextStyle(fontSize: 20.0),
                ),
                onTap: () {
                  Get.toNamed(Routes.TEST_LIST);
                  // Do something when the item is clicked
                  // For example, navigate to a new screen
                 // Get.to(ExamTestSeriesDetailView(testSeries: examTestSeriesData[index]));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
