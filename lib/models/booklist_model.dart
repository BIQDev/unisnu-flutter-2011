import 'dart:io';

import 'package:flutter/foundation.dart';

class BookListModel {
  final String id; // id dari record didatabase
  final String title; // Judul buku
  final String imagePath; // URL gambar buku
  final File imageFile; // Untuk handle file upload berupa object File

  BookListModel({
    @required this.id,
    @required this.title,
    @required this.imagePath,
    this.imageFile,
  });

  /* fromJson() digunakan untuk konversi data JSON
  * yang diterima dari REST API
  * Menjadi Map<String, dynamic>
  */
  BookListModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        imagePath = json['image_path'],
        imageFile = json["image_file"];
}
