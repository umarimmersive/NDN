import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/ColorValues.dart';
import '../../../../utils/global_widgets/textfield_ui.dart';

class MyBottomSheet extends StatefulWidget {
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  final List<bool> checkedOptions = [false, false, false];

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
                  'Submit Test',
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
          Divider(
            height: 1,
            color: Colors.black,
          ),
          Center(
            child: Text(
              'Are you sure you want to end this time ?',
              style: TextStyle(fontSize: 16),
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 00),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.access_time_outlined,
                          color: Colors.black,
                          size: 24.0,
                        ),
                      ),

                      SizedBox(
                        width: 05,
                      ),
                      Text('Not Answer',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300, color: Colors.lightBlue,)),
                    ],),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [

                      CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.,
                          color: Colors.black,
                          size: 24.0,
                        ),
                      ),
                      SizedBox(
                        width: 05,
                      ),
                      Text('Answer',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300, color: Colors.lightBlue,)),
                    ],),
                )

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Explanation',
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            ),
          ),




          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back(result: checkedOptions);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
