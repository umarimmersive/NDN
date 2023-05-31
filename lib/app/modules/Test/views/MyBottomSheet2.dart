import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/TestController.dart';

class MyBottomSheet2 extends StatelessWidget {
  final TestController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            30,
          ),
          topLeft: Radius.circular(
            30,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Making Scheme',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              child: Divider(
                height: 1,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '(${controller.marking_number}) if the correct options is selected;',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'No Marks will be awarded if no attempt is made;',
                style: TextStyle(fontSize: 16),
              ),
            ),
            controller.negative_marking=='Yes'?
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Yes Nagative markes will be awarded if incorrectly attampted ',
                style: TextStyle(fontSize: 16),
              ),
            ):
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'No Nagative markes will be awarded if incorrectly attampted ',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
