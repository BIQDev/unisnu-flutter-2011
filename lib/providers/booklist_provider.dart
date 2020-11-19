import 'package:flutter/material.dart';
import 'package:perpus/models/booklist_model.dart';

class BookListProvider with ChangeNotifier {
  List<BookListModel> _list = [
    BookListModel(
      id: "1",
      title: "Judul 1",
      imagePath: "assets/mock/book.png",
    ),
    BookListModel(
      id: "2",
      title: "Judul 2",
      imagePath: "assets/mock/book.png",
    ),
    BookListModel(
      id: "3",
      title: "Judul 3",
      imagePath: "assets/mock/book.png",
    ),
  ];

  List<BookListModel> get list {
    return [..._list];
  }

  void fetchList() {
    notifyListeners();
  }
}
