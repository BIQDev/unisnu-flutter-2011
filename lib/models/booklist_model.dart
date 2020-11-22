import 'dart:io';

import 'package:flutter/foundation.dart';

class BookListModel {
  final String id;
  final String title;
  final String imagePath;
  final File imageFile;
  bool isFavourite;

  BookListModel({
    @required this.id,
    @required this.title,
    @required this.imagePath,
    this.imageFile,
    this.isFavourite = false,
  });

  BookListModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        imagePath = json['image_path'],
        imageFile = json["image_file"];
}
