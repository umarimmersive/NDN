import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/models/Report_option_model.dart';

import '../../../../utils/constants/ColorValues.dart';
import '../../../../utils/global_widgets/textfield_ui.dart';
import '../controllers/TestController.dart';

class MyBottomSheet extends StatefulWidget {
  late String Questionid;
  var id;
  MyBottomSheet({Key? key,required this.id}) : super(key: key);
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  final TestController Controller = Get.find();


  @override
  Widget build(BuildContext context) {

    print('widget.id-------------------------${widget.id}');
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
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: Divider(
                height: 1,
                color: Colors.black,
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: Controller.Report_option_list.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(Controller.Report_option_list[index].name),
                  value: Controller.value[index],
                  onChanged: (value) {

                     for(int i=0;i<Controller.value.length;i++){
                       Controller.value[i]=false;
                       }

                      Controller.value[index] = value!;

                       print('----------------true');

                       Controller.value[index] = true;
                       Controller.selectValue.value=Controller.Report_option_list[index].id.toString();
                       print('selectValue----------${Controller.selectValue.value}');




setState(() {

});



                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0,left: 16,right: 10),
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
                controller: Controller.text,
                //validator: (p0)=> Validators.emailValidator(p0),
                fontSize: 14,
                maxLength: 50,
                minLines: 1,
                hintText: "Give Feedback (Optional)",
                hintStyle: ColorValues.HINT_TEXT_COLOR,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                readOnly: false,
                keyboardType: TextInputType.text,
               /* prefixIcon: Icon(
                  Icons.mail,
                  color:  ColorValues.HINT_TEXT_COLOR,
                  size: 16.0,
                ),*/
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                   Controller.post_Report(report_option_id: Controller.selectValue.value,question_id:widget.id );
                   Get.back();

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0,right: 40.0),
                        child: Text('Submit'),
                      ),
                      Controller.isLoading2.isTrue?
                          CupertinoActivityIndicator():
                          Container()
                    ],
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
