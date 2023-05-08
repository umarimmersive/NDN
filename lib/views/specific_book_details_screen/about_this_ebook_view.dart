import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AboutThisEBook extends StatelessWidget {
  String bookName;
  String description;

  AboutThisEBook({super.key, required this.bookName,required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "About this eBook - $bookName",
            style: const TextStyle(fontSize: 16),
          ),
        ),
        body:  SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(

          "${description!.toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ') ?? ''}"
        ))));
  }
}
