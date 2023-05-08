// ignore: file_names
// ignore: file_names
// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore

class NewsModal {
  // ignore: prefer_typing_uninitialized_variables
  var status;
  var result;

  NewsModal(this.status ,this.result);

  NewsModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  // ignore: prefer_typing_uninitialized_variables
  var author;
  var description;
  var publishedAt;
  var sourceName;
  var title;
  var url;
  var urlToImage;
  var isLast;

  Result(
      {this.author,
      this.description,
      this.publishedAt,
      this.sourceName,
      this.title,
      this.isLast,
      this.url,
      this.urlToImage});

  Result.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    description = json['description'];
    publishedAt = json['publishedAt'];
    sourceName = json['sourceName'];
    title = json['title'];
    isLast = json['isLast'];
    url = json['url'];
    urlToImage = json['urlToImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['description'] = description;
    data['publishedAt'] = publishedAt;
    data['sourceName'] = sourceName;
    data['isLast'] = isLast;
    data['title'] = title;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    return data;
  }
}
