/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes/testing_epub.dart';

class FreeEbooksView extends StatefulWidget {
  const FreeEbooksView({Key? key}) : super(key: key);

  @override
  State<FreeEbooksView> createState() => _FreeEbooksViewState();
}

class _FreeEbooksViewState extends State<FreeEbooksView> {
  final imagesURL = [
    'assets/books_covers/1.jpg',
    'assets/books_covers/3.jpg',
    'assets/books_covers/4.jpg',
    'assets/books_covers/5.jpg',
    'assets/books_covers/8.jpg',
  ];
  final imagesURLHindi = [
    'assets/books_covers/hindi/h1.jpg',
    'assets/books_covers/hindi/h2.jpg',
    'assets/books_covers/hindi/h3.jpg',
    'assets/books_covers/hindi/h4.jpg',
    'assets/books_covers/hindi/h6.jpg',
  ];
  final booksNames = [
    'Jodi Picoult',
    'Heart Spring ',
    'Kristin Hannah',
    'Leave the world',
    'The Indian English',
  ];

  bool englishPressed = true;

  EPUBTEST epubtest = EPUBTEST();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Free eBooks"
            ""),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "English",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color:
                      englishPressed == true ? Colors.blue : Colors.black),
                ),
                Switch(
                    value: englishPressed == false ? true : false,
                    activeTrackColor: Colors.blue.shade200,
                    onChanged: (value) {
                      setState(() {
                        englishPressed = !englishPressed;
                      });
                    }),
                Text(
                  "Hindi",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color:
                      englishPressed == false ? Colors.blue : Colors.black),
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                primary: true,
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 2,
                    crossAxisCount: 2,
                    childAspectRatio: 0.6),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Get.to(EPUBTEST());

                      // Get.to(SubjectWiseView(
                      //   coachingName: '${widget.map['name'][widget.index]}',
                      //   examType:
                      //   '${dashboardController.examCategories.value}',
                      //   subjectName:
                      //   '${coursesNames['name'][index].toString()}',
                      // ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 7,
                        color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
                          color: Colors.transparent,
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.55,
                                child: Image.asset(
                                  englishPressed == true
                                      ? imagesURL[index]
                                      : imagesURLHindi[index],
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    booksNames[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )),
                              const Text(
                                "FREE",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
*/
