import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:national_digital_notes_new/views/about_screen/about_us_view.dart';
import 'package:national_digital_notes_new/views/login_screen/login_view.dart';
import 'package:national_digital_notes_new/views/verification_screen/verification_views.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../controllers/profile_settings_controller.dart';
import '../../utils/constants/ColorValues.dart';
import '../../utils/constants/Globle_data.dart';
import '../../utils/constants/api_service.dart';
import '../../utils/constants/heading_text_styles.dart';
import '../../utils/constants/my_colors.dart';
import '../../utils/constants/my_local_service.dart';
import '../../utils/global_widgets/textfield_ui.dart';
import '../../utils/routes/app_pages.dart';
import '../pre_login_screen/pre_login_screen.dart';
import '../privacy_and_terms.dart';
import 'package:http/http.dart' as http;
class SettingProfileRoute extends StatefulWidget {
   bool? backButton;
   SettingProfileRoute({super.key, this.backButton});

  @override
  SettingProfileRouteState createState() => SettingProfileRouteState();
}

class SettingProfileRouteState extends State<SettingProfileRoute> {

@override
  void initState() {

  nameController.text=userData!.name;
  mobileController.text=userData!.phoneNumber;
    // TODO: implement initState
    super.initState();
  }







  final controller = Get.put(ProfileSettingsController());
  final isLoading=false.obs;
  final wishlist_status = true;



  Remove_Account() async{
    // bookList.clear();
    isLoading(true);

    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'removeUser'),body: {
      "user_id":userData!.userId,
    });

    var data=jsonDecode(response.body);

    log("=========$data");

    if (data['success'] == true) {

      my_local_service.logout();

     // Get.offAll( PreLoginScreen());

      isLoading(false);

      setState(() {

      });
      //update();
    } else if (data['success'] == false) {
      //book_detils.value = data;
      isLoading(false);
      setState(() {

      });
    }

  }


   get_profile() async{
  // bookList.clear();
  isLoading(true);


  http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'getProfile'),body: {
    "user_id":userData!.userId,
  });

  var data=jsonDecode(response.body);

  log("data=========$data");

  if (data['success'] == true) {
    await my_local_service.updateSharedPreferences(data['data']);

    setState(() {

    });
    isLoading(false);

    setState(() {

    });
    //update();
  } else if (data['success'] == false) {
    //book_detils.value = data;
    isLoading(false);
    setState(() {

    });
  }

}

  var isdark = false;
  bool Edit_profile_Switch=false;
TextEditingController nameController = TextEditingController();
TextEditingController mobileController = TextEditingController();

 File? imageFile;

 getFromGallery() async {
  PickedFile? pickedFile = await ImagePicker().getImage(
    source: ImageSource.gallery,
    // maxWidth: 1800,
    // maxHeight: 1800,
  );
  if (pickedFile != null) {
    imageFile = File(pickedFile.path);
    print('------------------$imageFile');
    setState(() {

    });
   // update_profile_pic();
  }
}

  Future update_profile_pic() async {

  isLoading(true);
  setState(() {

  });

  print("=======================${userData!.userId}");
  print("=======================${mobileController.text.toString()}");
  print("=======================${nameController.text.toString()}");
  //  context.loaderOverlay.show();

  var postUri = Uri.parse(ApiService.BASE_URL+'profile');
  var request = new http.MultipartRequest("POST", postUri);

  request.headers['Accept'] = 'application/json';

  request.fields['user_id']= userData!.userId;
  request.fields['phone']=mobileController.text.toString();
  request.fields['name']=nameController.text.toString();


  if (imageFile!=null) {
    print('Not null');
    http.MultipartFile multipartFile =
    await http.MultipartFile.fromPath('image', imageFile!.path);
    request.files.add(multipartFile);
  } else {
    print('null null');
  }
  request.send().then((result) async {
    http.Response.fromStream(result).then((response) async {
      var jsonString = jsonDecode(response.body);
      print(jsonString);
      if (jsonString['success'] == true) {

     await get_profile();
       /* User_detail();
        print("Uploaded!");
        print('response.body ' + response.body);
        attachmentPath.value = jsonString['data']['image'];*/
        Get.snackbar( "Success",
          jsonString['message'].toString(),
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(
              vertical: 5,horizontal: 5
          ),
          barBlur: 0,
          colorText: Colors.white,
          maxWidth: double.infinity,
          snackStyle: SnackStyle.GROUNDED,
          borderRadius: 10,);
        nameController.clear();
        mobileController.clear();
        Edit_profile_Switch=false;


        isLoading(false);
        setState(() {

        });

        //dashboardController.getProfileData();
      } else {
        isLoading(false);

        setState(() {

        });

        Get.snackbar( "Failed",
          jsonString['message'].toString(),
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(
              vertical: 5,horizontal: 5
          ),
          barBlur: 0,
          colorText: Colors.white,
          maxWidth: double.infinity,
          snackStyle: SnackStyle.GROUNDED,
          borderRadius: 10,);

        // Get.snackbar(
        //   "Failed",
        //   jsonString['message'].toString(),
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.redAccent,
        //   colorText: Colors.white,
        //   borderRadius: 5,
        // );
      }

      return response.body;
    });
  })
      .catchError((err) { print('error : ' + err.toString());
  Get.snackbar(
    "Image Size is Bigger then 5MB",
    "",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.blue,
    colorText: Colors.white,
    borderRadius: 5,
    duration: Duration(seconds: 6),
  );
  })
      .whenComplete(() {
    //context.loaderOverlay.hide();
  });
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey_10,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 180.0,
              floating: false,
              pinned: true,
              backgroundColor: MyColors.primary,
              flexibleSpace: const FlexibleSpaceBar(),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(190),
                child: SizedBox(
                  height: 190,
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        'assets/home_screen_images/material_bg_1.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      userData!.profileImage!="null"?
                      //FileImage(File(path))
                      imageFile==null?
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50, left: 14, top: 10),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[100],
                          child:  CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(
                                ApiService.IMAGE_URL+userData!.profileImage),
                          ),
                        ),
                      ):
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50, left: 14),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[100],
                          child:  CircleAvatar(
                            radius: 55,
                            backgroundImage: FileImage(imageFile!),
                          ),
                        ),
                      )
                          :
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 14),
                        child: CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.grey[100],
                          child: CircleAvatar(
                            radius: 33,
                            backgroundImage: AssetImage('assets/profile.png'),
                          ),
                        ),
                      ),

                      Edit_profile_Switch==true?
                      Positioned(
                        bottom: 60,
                        left: 100,
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: IconButton(
                              onPressed: () {
                                getFromGallery();
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              )),
                        ),
                      ):
                          SizedBox(),


                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("${userData!.name}",
                                  style: MyText.body2(context)!.copyWith(
                                      color: Colors.grey[100],
                                      fontWeight: FontWeight.bold)),
                              Container(height: 3),
                              Text("${userData!.emailId}",
                                  style: MyText.body2(context)!
                                      .copyWith(color: Colors.grey[100])),
                              SizedBox(
                                height: 05,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.toNamed(Routes.DESHBOARD,parameters: {"index":"0"});
                  //Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: (String value) async {


                    Get.offAll( PreLoginScreen());
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: "Logout",
                      child: Text("Logout"),
                    ),
                  ],
                )
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Card(
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "Edit",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Switch(
                              value: Edit_profile_Switch,
                              onChanged: (value) {
                                print("========$value");
                                Edit_profile_Switch=value;
                                setState(() {

                                });


                              },
                            ),
                          ],
                        )),
                    Edit_profile_Switch!=true?
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                      InkWell(
                        highlightColor: Colors.grey.withOpacity(0.1),
                        splashColor: Colors.grey.withOpacity(0.1),
                        onTap: () => () {},
                        child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${userData!.name}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text("Name",
                                    style: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
                              ],
                            )),
                      ),
                      const Divider(height: 0),
                      InkWell(
                        highlightColor: Colors.grey.withOpacity(0.1),
                        splashColor: Colors.grey.withOpacity(0.1),
                        onTap: () => () {},
                        child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${userData!.phoneNumber}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text("Phone",
                                    style: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
                              ],
                            )),
                      ),
                      const Divider(height: 0),
                      InkWell(
                        highlightColor: Colors.grey.withOpacity(0.1),
                        splashColor: Colors.grey.withOpacity(0.1),
                        onTap: () => () {},
                        child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${userData!.emailId}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text("e-mail",
                                    style: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
                              ],
                            )),
                      ),
                      const Divider(height: 0),
                    ],):
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: MediaQuery.of(context).size.height * 0.01),
                            child: TextFieldDesigned(
                              //enableInteractiveSelection: false,
                              maxLines: 1,
                              cursorColor: ColorValues.BLACK,
                              controller: nameController,
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
                                vertical: 10,
                                horizontal: MediaQuery.of(context).size.height * 0.01),
                            child: TextFieldDesigned(
                              enableInteractiveSelection: false,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              cursorColor: ColorValues.BLACK,
                              controller: mobileController,
                              validator: (value) {
                                if(value != null && value!.length < 10){
                                  return 'Please fill valid mobile number.';
                                }else
                                  /* if(value!.length>13){
                                return 'Enter valid phone number';
                              }*/
                                  /*if (value != null && !value.isEmail) {
                            return 'Invalid Email ID.';
                          }*/
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
                            padding: const EdgeInsets.all(5.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent[400], elevation: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[


                                    Text("Submit", style: TextStyle(color: Colors.white)),
                                    isLoading==true?
                                    Padding(padding: EdgeInsets.only(left: 10),
                                      child: CupertinoActivityIndicator(color: Colors.white,),
                                    ):
                                    SizedBox()
                                  ],)
                                ,
                                onPressed: () async{
                                  update_profile_pic();
                                },
                              ),
                            ),
                          ),
                        ],)

                  ],
                ),
              ),
              Container(height: 10),
              Card(
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Settings",
                              style: MyText.subhead(context)!.copyWith(
                                  color: MyColors.primaryDark,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(height: 10),
                    const Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Get.to( VerificationCodeRoute(otp: '1234',));
                                },
                                child: Text("Set Password",
                                    style: MyText.medium(context).copyWith()),
                              ),
                              const Spacer(),
                              const Text(""),
                            ],
                          )),
                    ),
                    const Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: (){
                        showAlertDialog(context);
                      },
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            children: <Widget>[
                              Text("Delete Account",
                                  style: MyText.medium(context).copyWith()),
                              const Spacer(),
                              const Icon(
                                Icons.delete,
                                color: Colors.grey,
                              )
                            ],
                          )),
                    ),
                    const Divider(height: 0),
                   /* InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => () {},
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            children: <Widget>[
                              Text("Mode",
                                  style: MyText.medium(context).copyWith()),
                              const Spacer(),
                              const Text("Light"),
                              GetBuilder<ProfileSettingsController>(
                                builder: (_) => Switch(
                                    value: controller.isdark,
                                    onChanged: (state) {
                                      controller.changeTheme(state);
                                    }),
                              ),
                              const Text("Dark"),
                            ],
                          )),
                    ),
                    const Divider(height: 0),*/
                  ],
                ),
              ),
              Container(height: 10),
              Card(
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Support",
                              style: MyText.subhead(context)!.copyWith(
                                  color: MyColors.primaryDark,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(const TermsScreen());
                        },
                        child: const Text(
                          "Terms",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(const PoliciesScreen());
                        },
                        child: const Text(
                          "Privacy",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: GestureDetector(
                        onTap: () {
                          //Get.toNamed(Routes.ABOUT_US);
                          Get.to(const AboutAppSimpleBlueRoute());
                        },
                        child: const Text(
                          "About",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Container(height: 15),
              Text("Build Version 1.0.1",
                  style: MyText.caption(context)!
                      .copyWith(color: MyColors.grey_40)),
              Container(height: 15),
            ],
          ),
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child:  Text("Do you want to delete account?"),
      onPressed: () {
        Remove_Account();
      },
    );
    Widget noButton = ElevatedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Do you want to delete account"),
      content: const Text("We hate to see you leave..."),
      actions: [
        noButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
