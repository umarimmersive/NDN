import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/ColorValues.dart';
import '../../../../utils/global_widgets/textfield_ui.dart';

class MyBottomSheet4 extends StatefulWidget {
  @override
  _MyBottomSheet4State createState() => _MyBottomSheet4State();
}

class _MyBottomSheet4State extends State<MyBottomSheet4> {


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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '',
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
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_outlined,
                    color: Colors.red,
                    size: 100.0,
                    semanticLabel: '',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0,right: 05),
                    child: Text(textAlign: TextAlign.center,'Your test will submitted if you try to sneck away from the test screen',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {

                     Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0,right: 40.0),
                    child: Text('Back to test'),
                  ),
                ),
              ],
            ),
          ],

        ),
      ),
    );
  }
}
