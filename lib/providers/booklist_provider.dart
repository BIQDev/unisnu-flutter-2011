import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:perpus/models/booklist_model.dart';
import 'package:perpus/providers/setting_provider.dart';
import 'package:provider/provider.dart';

class BookListProvider with ChangeNotifier {
  List<BookListModel> _list = [
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
    return [..._list];
  }

  Future<void> fetchList(BuildContext context) async {
    final settingData = Provider.of<SettingProvider>(context);
    String url =
        "${settingData.setting.apiHost}/perpus-api/booklist/${settingData.setting.userName}";
    http.Response res;
    try {
      final resTmp = await http.get(url);
      res = resTmp;
    } catch (e) {
      throw (e);
    }
    List<BookListModel> bookListData = (json.decode(res.body)["data"] as List)
        .map((i) => BookListModel.fromJson(i))
        .toList();
    this._list = bookListData;
    notifyListeners();
  }
}
