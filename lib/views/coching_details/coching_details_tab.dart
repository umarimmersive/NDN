




import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/routes/app_pages.dart';
import 'package:national_digital_notes_new/views/dashboard_screen/controller_home_view.dart';
import 'package:national_digital_notes_new/views/detailed_course_screen/detailed_course_view.dart';

import '../../controllers/tab_simple_controller.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/api_service.dart';
class Coching_details_tab extends StatefulWidget {
  String id;
  Coching_details_tab({Key? key, required this.id}) : super(key: key);

  @override
  State<Coching_details_tab> createState() => _Coching_details_tabState();
}

class _Coching_details_tabState extends State<Coching_details_tab> {
  bool isGridView = true;
  TabsLightController tabController = Get.put(TabsLightController());


  @override
  void initState() {
    callApi();
    print("idd+++++++=================${widget.id}");
    // TODO: implement initState
    super.initState();
  }

  var Coching_list=[].obs;

  final isLoading=false.obs;
  final status=false.obs;

  callApi() async{
    // bookList.clear();
    isLoading(true);

    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'examCoachingList'),body: {
      "exam_id":widget.id
    });

    var data=jsonDecode(response.body);
    status.value=data['success'];

    if (data['success'] == true) {


      print(response);
      print(response.body);
      Coching_list.addAll(data['data']);
      //book_detils.value = data['data'];
      print("88888*******");
      print("==============$Coching_list");

      setState(() {});

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





  final List<IconData> iconData = <IconData>[
    Icons.book,
    Icons.school,
    Icons.ac_unit_rounded,
    Icons.access_alarm_outlined,
    Icons.class_,
    Icons.book,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "COACHING",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        letterSpacing: 1.05,
                        fontWeight: FontWeight.w600),
                  ),
                  isGridView == true
                      ? IconButton(
                      onPressed: () {
                        setState(() {
                          isGridView = !isGridView;
                        });
                      },
                      icon: const Icon(
                        Icons.grid_view_rounded,
                        size: 20,
                      ))
                      : IconButton(
                      onPressed: () {
                        setState(() {
                          isGridView = !isGridView;
                        });
                      },
                      icon: const Icon(Icons.list, size: 20))
                ],
              ),
            ),

            isLoading==true?
            Expanded(child: Center(child: CupertinoActivityIndicator())):
            status.value==true?
            Expanded(
              child: GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  primary: true,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(0),
                  gridDelegate: isGridView == false
                      ? const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: 3)
                      : const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.7,
                      crossAxisSpacing: 2),
                  itemCount: Coching_list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        print(Coching_list);
                        print(Coching_list[index]['id']);
                        //Get.to(DetailedCoachingView(coursesId: Coching_list[index]['id'].toString(),cochingName:Coching_list[index]['coaching_name']));

                        var data={
                          "coursesId":"${Coching_list[index]['id'].toString()}",
                          "cochingName":"${Coching_list[index]['coaching_name'].toString()}",
                        };
                        print('-----------------api');

                        Get.toNamed(Routes.COCHING_DETAILS,parameters: data);

                        setState(() {
                          callApi();
                        });
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: isGridView == true
                              ? Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Obx(
                                  ()=> Container(
                                padding: const EdgeInsets.only(right: 10),
                                color: Colors.transparent,
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              top: 10,
                                              bottom: 10),
                                          alignment: Alignment.centerLeft,
                                          child: Text(

                                            Coching_list[index]['coaching_name'].toString(),

                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w600),
                                          )),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 0, bottom: 10),
                                          child:CachedNetworkImage(
                                            imageUrl:
                                            '${ApiService.IMAGE_URL+Coching_list[index]['logo']}'
                                            ,fit: BoxFit.cover,)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                              : listTile(
                            index,
                            '${Coching_list[index]['coaching_name']}',
                            '${Coching_list[index]['description']}',
                            '${Coching_list[index]['logo']}',
                          )),
                    );
                  }),

            )

                :
            Center(child: Text('No coching found.'))
          ]),
    );
  }
}