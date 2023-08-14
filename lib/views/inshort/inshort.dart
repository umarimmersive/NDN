// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:national_digital_notes_new/timer_animated.dart';
import 'package:national_digital_notes_new/utils/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/constants/api_service.dart';
import '../../utils/global_widgets/globle_var.dart';
import '../../utils/global_widgets/snackbar.dart';
import '../add_to_cart_screen/add_to_cart_view.dart';
import 'NewsCards.dart';
import 'NewsDummy.dart';
import 'NewsModal.dart';

// ignore: use_key_in_widget_constructors
class InShort extends StatefulWidget {
  @override
  //ignore: library_private_types_in_public_api
  _InShortState createState() => _InShortState();
}

class Animal {
  final int id;
  final String name;

  Animal({
    required this.id,
    required this.name,
  });
}

class _InShortState extends State<InShort> {

  bool completed = false;
  int index = 0;

  // late NewsModal newsModal;

  @override
  void initState() {
    get_news();
    setupLastIndex();
    get_category_list();
    super.initState();
  }
  TextEditingController dateController = TextEditingController();
  RxBool isLoading = false.obs;

  var news_list = [].obs;
  var category_list = [].obs;

  var response;
  List<dynamic> category=[].obs;

  final isQuiz=''.obs;

  get_news() async {
    print('category======================${category.join(',')}');
    try {
      isLoading(true);
      setState(() {

      });

      if(dateController.text.isEmpty){
        var now = new DateTime.now();
        var formatter = new DateFormat('yyyy-MM-dd');
        String formattedDate = formatter.format(now);
        print(formattedDate);// 2016-01-25
        dateController.text=formattedDate.toString();
        Today_date.value=formattedDate.toString();
      }
      Today_date.value=dateController.text.toString();
      Select_language.value=_selectedView.toString();

      print("_selectedView=======================$_selectedView");
      print("dateController=======================${dateController.text}");
      news_list.clear();

      response = await ApiService().Get_news(dateController.text, _selectedView,category.join(','));
      print({'$response'});

      if (response['success'] == true) {
        news_list.addAll(response['data']);
        isQuiz.value=response['data'][0]['is_quiz'].toString();
        print("news_list==============================$news_list");
        print("is_quiz0-----------------${response['data'][0]['is_quiz'].toString()}");
        // snackbar(response['message']);


        isLoading(false);

        setState(() {

        });
      } else if (response['success'] == false) {
        snackbar(response['message']);
        isLoading(false);
        setState(() {

        });
      }
    } finally {
      isLoading(false);
    }
  }


  get_category_list() async {
    try {
      isLoading(true);
      setState(() {

      });
      category_list.clear();

      response = await ApiService().Get_category();
      print({'$response'});

      if (response['success'] == true) {
        category_list.addAll(response['data']);
        print("news_list==============================$news_list");
        // snackbar(response['message']);


        isLoading(false);

        setState(() {

        });
      } else if (response['success'] == false) {
        snackbar(response['message']);

        isLoading(false);


        setState(() {

        });
      }
    } finally {
      isLoading(false);
    }
  }



  void updateIndex(newIndex) {
    setState(() {
      index = newIndex;
    });
  }


  void setupLastIndex() async {}



  void updateContent(direction) {
    if (index <= 0 && direction == DismissDirection.down) {
      index = news_list.length - 1;
    } else if (index == news_list.length - 1 &&
        direction == DismissDirection.up) {
      index = 0;
      completed = true;
    } else if (direction == DismissDirection.up) {
      index++;
    } else {
      index--;
    }
    updateIndex(index);
  }



  String getShareText() {
    return "${news_list[index].title}\n${news_list[index].url}";
  }

  void _showMultiSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return Container(
          height: 250,
          width: 250,
          child: Scaffold(
              body: Center(
                child: MultiSelectContainer(
                    prefix: MultiSelectPrefix(
                        selectedPrefix: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                        disabledPrefix: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.do_disturb_alt_sharp,
                            size: 14,
                          ),
                        )),
                    items: [
                      MultiSelectCard(value: 'Dart', label: 'Dart'),
                      MultiSelectCard(value: 'Python', label: 'Python'),
                      MultiSelectCard(value: 'JavaScript', label: 'JavaScript'),
                      MultiSelectCard(value: 'Java', label: 'Java', enabled: false),
                      MultiSelectCard(value: 'C#', label: 'C#'),
                    ],
                    onChange: (allSelectedItems, selectedItem) {}),
              )),
        );
      },
    );
  }

  Widget newsCard(int index) {
    print("============+${news_list[index]['image']}");
    print("============+${news_list[index]['title']}");
    print("============+${news_list[index]['description']}");
    return NewsCard(
      isLast: '',
      imgUrl: ApiService.IMAGE_URL + news_list[index]['image'],
      primaryText: news_list[index]['title'],
      secondaryText: news_list[index]['description'],
      sourceName: '',
      author: '',
      publishedAt: '',
      url: '',
    );
  }

   String _selectedView = 'English';

  List<DismissDirection> listOfDirections = [
    DismissDirection.startToEnd,
    DismissDirection.up,
    DismissDirection.down
  ];

  @override
  Widget build(BuildContext context) {
    int prevIndex = index <= 0 ? 0 : index - 1;
    int nextIndex = index == news_list.length - 1 ? 0 : index + 1;
    return Scaffold(
        appBar: AppBar(

          iconTheme: IconThemeData(
            color: Colors.white, // <-- SEE HERE
          ),
          title: Text('Current Affairs'),
          leading: IconButton(
            onPressed: () {
              Get.toNamed(Routes.DESHBOARD,parameters: {"index":"0"});
            },
            icon: Icon(Icons.arrow_back),
          ),
          actions: <Widget>[



            IconButton(
                onPressed: () async {

                  DateTime? pickedDate = await showDatePicker(
                      context: context,

                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(2020, 1),
                      lastDate: DateTime.now()
                  );

                  if(pickedDate != null ){
                    print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                    print(formattedDate); //formatted date output using intl package =>  2022-07-04
                    //You can format date as per your need

                    setState(() {
                      dateController.text = formattedDate; //set foratted date to TextField value.
                    });
                    await  get_news();
                  }else{
                    print("Date is not selected");
                  }
                 /* Get.to(const AddToCartView());*/
                },
                icon: const Icon(Icons.calendar_month)),
            PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      value: 0,
                      child: const Text("Language"),
                      onTap: () {

                      },
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("Category"),
                    ),
                  ];
                }, onSelected: (value) async {
              if (value == 0) {
                await show_Dialog();


                if (kDebugMode) {
                  print("My account menu is selected.");
                  print("My account menu is selected.==========$_selectedView");
                }
              } else if (value == 1) {
                showModalBottomSheet<void>(
                  // context and builder are
                  // required properties in this widget
                  context: context,
                  builder: (BuildContext context) {
                    // we set up a container inside which
                    // we create center column and display text

                    // Returning SizedBox instead of a Container
                    return Container(
                      height: 250,
                      width: 150,
                      child: Scaffold(
                          appBar: AppBar(
                            iconTheme: IconThemeData(color: Colors.black),
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            title: Text(
                                  'Select Category',
                              style: TextStyle(color: Colors.black,fontSize: 16),
                            ),
                          ),
                          backgroundColor: Colors.grey.shade300,
                          body: Center(
                            child: MultiSelectContainer(
                                prefix: MultiSelectPrefix(
                                  selectedPrefix: const Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                items: [
                                  for(int i=0;i<category_list.length;i++)
                                    MultiSelectCard(value: category_list[i]['id'], label: category_list[i]['name']),
                                ],
                                onChange: (allSelectedItems, selectedItem) async{
                                  category.clear();
                                  category.addAll(allSelectedItems);
                                  await get_news();
                                }),
                          )),
                    );
                  },
                );
                if (kDebugMode) {
                  print("Settings menu is selected.");
                }
              }
            }),

          ],
        ),
        body:
        isLoading == false ?
        news_list.isEmpty ? Center(child: Text('No data found'),) :
        GestureDetector(
          onHorizontalDragEnd: ((details) {
            if (kDebugMode) {
              print('Horizontal Dragged');
            }
            // ignore: deprecated_member_use
            launch('${news_list[index]['url']??'https://ndn.manageprojects.in/login'}');
          }),
          child: Center(
            child: Stack(
              children: [
                Dismissible(
                  background: newsCard(prevIndex),
                  secondaryBackground: newsCard(nextIndex),
                  resizeDuration: const Duration(milliseconds: 10),
                  key: UniqueKey(),
                  direction: DismissDirection.up,
                  onDismissed: (direction) {
                    if (news_list[news_list.length - 1] != 'true') {
                      updateContent(direction);
                    } else {
                      deactivate();
                    }
                    if (kDebugMode) {
                      print(direction);
                    }
                  },
                  child: newsCard(index),
                ),

                if (index == news_list.length - 1)
                  if(isQuiz.value=='1')
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 25.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(AnimatedTimer());
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(
                              child: Text(
                                "Start Quiz",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    letterSpacing: 1.2),
                              )),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ) :
        Center(child: CupertinoActivityIndicator())
    );
  }

  Future show_Dialog() {
    return showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(
              title: const Text("Select Language"),
              actions: <Widget>[
                CheckedPopupMenuItem(
                  checked: _selectedView == 'English',
                  value: 'English',
                  child: const Text('English'),
                ),
                CheckedPopupMenuItem(
                  checked: _selectedView == 'Hindi',
                  value: 'Hindi',
                  child: const Text('Hindi'),
                ),
              ],
            )
    ).then((valueFromDialog)  {
      // use the value as you wish
      _selectedView=valueFromDialog.toString();
       get_news();
      print('================================$valueFromDialog');
    });
  }
}