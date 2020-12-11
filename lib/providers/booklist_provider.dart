import 'package:flutter/material.dart';

import 'package:perpus/models/booklist_model.dart';

class BookListProvider with ChangeNotifier {
  // _list ini adalah model utama dari daftar buku kita
  // akan digunakan untuk menampilkan daftar buku
  // yang didapat dari REST API
  List<BookListModel> _list = [
    // Kita buat dummy data atau data palsu
    // hanya untuk tujuan mockup dulu
    BookListModel(
      id: "1",
      title: "Judul 1",
      imagePath: "assets/book.png",
    ),
    BookListModel(
      id: "2",
      title: "Judul 2",
      imagePath: "assets/book.png",
    ),
    BookListModel(
      id: "3",
      title: "Judul 3",
      imagePath: "assets/book.png",
    ),
  ];

  List<BookListModel> get list {
    return [...this._list];
  }
}
