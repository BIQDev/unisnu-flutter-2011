import 'package:flutter/foundation.dart';

class BookListModel {
  final String id;
  final String title;
  final String imagePath;
  bool isFavourite;

  BookListModel({
    @required this.id,
    @required this.title,
    @required this.imagePath,
    this.isFavourite = false,
  });

  BookListModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        imagePath = json['image_path'];
}
