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
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Report Question',
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
          ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(options[index]),
                value: checkedOptions[index],
                onChanged: (value) {
                  setState(() {
                    checkedOptions[index] = value!;
                  });
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Explanation',
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: MediaQuery.of(context).size.height * 0.02),
            child: TextFieldDesigned(
              enableInteractiveSelection: false,
              maxLines: 1,
              cursorColor: ColorValues.BLACK,
              //controller: controller.emailController,
              //validator: (p0)=> Validators.emailValidator(p0),
              fontSize: 14,
              maxLength: 50,
              minLines: 1,
              hintText: "Give Feedback (Optional)",
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
