import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';

import 'package:perpus/models/booklist_model.dart';
import 'package:perpus/providers/setting_provider.dart';

class BookListProvider with ChangeNotifier {
  bool _isCreating = false;

  bool get isCreating {
    return this._isCreating;
  }

  Future<Map<String, dynamic>> create(
      BuildContext context, BookListModel data) async {
    this._isCreating = true;
    notifyListeners();
    final settingData = Provider.of<SettingProvider>(context, listen: false);
    if (data == null || data.title == "") {
      Map<String, dynamic> resInvalid = new Map<String, dynamic>();
      resInvalid["statusCode"] = 400;
      resInvalid["message"] = "Input is not valid";
      this._isCreating = false;
      notifyListeners();
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
      this._isCreating = false;
      notifyListeners();
      return resDecoded;
    } catch (e) {
      Map<String, dynamic> resInvalid = new Map<String, dynamic>();
      resInvalid["statusCode"] = statusCode != null ? statusCode : 400;
      resInvalid["message"] = e.toString();
      this._isCreating = false;
      notifyListeners();
      return resInvalid;
    }
  }

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
