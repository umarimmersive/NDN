// ignore: file_names
// ignore: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'Utils.dart';

class NewsCard extends StatelessWidget {
  final String url,
      imgUrl,
      primaryText,
      secondaryText,
      sourceName,
      author,
      isLast,
      publishedAt;


  const NewsCard(
      {super.key, required this.url,
        required this.imgUrl,
        required this.primaryText,
        required this.isLast,
        required this.secondaryText,
        required this.sourceName,
        required this.author,
        required  this.publishedAt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.2),
            child:CachedNetworkImage(
              imageUrl:
              imgUrl,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              primaryText.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  secondaryText.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '),
                  style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300,color: Colors.black87),
                )),
          ),
         
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
            child: Text(
              "Swipe For Read More",
              //"Swipe left for more at $sourceName by $author / ${Utils.timeAgoSinceDate(publishedAt)}",
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14.0,
                  color: Colors.grey),
            ),
          ),
        ],
      ),

    );
  }
}
