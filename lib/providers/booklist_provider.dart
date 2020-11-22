import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

import 'package:perpus/models/booklist_model.dart';
import 'package:perpus/providers/setting_provider.dart';
import 'package:provider/provider.dart';

class BookListProvider with ChangeNotifier {
  List<BookListModel> _list = [
    // BookListModel(
    //   id: "1",
    //   title: "Judul 1",
    //   imagePath: "assets/book.png",
    // ),
    // BookListModel(
    //   id: "2",
    //   title: "Judul 2",
    //   imagePath: "assets/book.png",
    // ),
    // BookListModel(
    //   id: "3",
    //   title: "Judul 3",
    //   imagePath: "assets/book.png",
    // ),
  ];

  bool _isFetching = false;

  List<BookListModel> get list {
    return [...this._list];
  }

  bool get isFetching {
    return this._isFetching;
  }

  Future<void> read(BuildContext context) async {
    this._isFetching = true;
    final settingData = Provider.of<SettingProvider>(context, listen: false);
    String url =
        "${settingData.setting.apiHost}/perpus-api/booklist/${settingData.setting.userName}";
    http.Response res;
    try {
      final resTmp = await http.get(url);
      res = resTmp;
    } catch (e) {
      this._isFetching = false;
      throw (e);
    }
    List<BookListModel> bookListData = (json.decode(res.body)["data"] as List)
        .map((i) => BookListModel.fromJson(i))
        .toList();
    this._list = bookListData;

    this._isFetching = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>> write(
      BuildContext context, BookListModel data) async {
    final settingData = Provider.of<SettingProvider>(context, listen: false);
    if (data == null || data.title == "") {
      Map<String, dynamic> resInvalid = new Map<String, dynamic>();
      resInvalid["statusCode"] = 400;
      resInvalid["message"] = "Input is not valid";
      return resInvalid;
    }

    List mimeStr = lookupMimeType(data.imageFile.path).split("/");

    var imageBytes = await data.imageFile.readAsBytes();
    var uri = Uri.parse(
        '${settingData.setting.apiHost}/perpus-api/booklist/${settingData.setting.userName}');
    var request = http.MultipartRequest('POST', uri)
      ..fields['title'] = data.title
      ..files.add(http.MultipartFile.fromBytes('image', imageBytes,
          filename: path.basename(data.imageFile.path),
          contentType: MediaType(mimeStr[0], mimeStr[1])));
    int statusCode;
    try {
      http.StreamedResponse res = await request.send();
      statusCode = res.statusCode;
      final String respStr = await res.stream.bytesToString();
      Map<String, dynamic> resDecoded = json.decode(respStr);
      resDecoded["statusCode"] = res.statusCode;
      return resDecoded;
    } catch (e) {
      Map<String, dynamic> resInvalid = new Map<String, dynamic>();
      resInvalid["statusCode"] = statusCode != null ? statusCode : 400;
      resInvalid["message"] = e.toString();
      return resInvalid;
    }
  }
}
