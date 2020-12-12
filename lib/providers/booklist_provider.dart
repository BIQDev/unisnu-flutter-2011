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

  bool _isCreating = false;
  bool get isCreating {
    return this._isCreating;
  }

  Future<Map<String, dynamic>> create(
      BuildContext context, BookListModel data) async {
    this._isCreating = true;
    notifyListeners();
    final settingData = Provider.of<SettingProvider>(context, listen: false);
    // Validasi data jika mungkin kosong atau null
    if (data == null || data.title == "") {
      Map<String, dynamic> resInvalid = new Map<String, dynamic>();
      resInvalid["statusCode"] = 400;
      resInvalid["message"] = "Input is not valid";
      this._isCreating = false;
      notifyListeners();
      return resInvalid;
    }

    // Membaca data gambar/image untuk diupload
    List mimeStr = lookupMimeType(data.imageFile.path).split("/");
    var imageBytes = await data.imageFile.readAsBytes();

    var uri = Uri.parse(
        '${settingData.setting.apiHost}/perpus-api/booklist/${settingData.setting.userName}');
    // Request HTTP dengan POST verb
    var request = http.MultipartRequest('POST', uri)
      ..fields['title'] = data.title
      ..files.add(http.MultipartFile.fromBytes('image', imageBytes,
          filename: path.basename(data.imageFile.path),
          contentType: MediaType(mimeStr[0], mimeStr[1])));
    int statusCode;
    try {
      // Gunakan blok "try" karena ada kemungkinan error yang tidak kita ketahui saat ini dari fungsu json.decode()
      http.StreamedResponse res = await request.send();
      statusCode = res.statusCode;
      final String respStr = await res.stream.bytesToString();
      Map<String, dynamic> resDecoded = json.decode(respStr); // Decode JSON
      resDecoded["statusCode"] = res.statusCode;
      this._isCreating = false;
      notifyListeners(); //Prosedur standard untuk memberitahu "listener" bahwa ada perubahan
      return resDecoded;
    } catch (e) {
      // Jika terjadi error
      Map<String, dynamic> resInvalid = new Map<String, dynamic>();
      resInvalid["statusCode"] = statusCode != null ? statusCode : 400;
      resInvalid["message"] = e.toString();
      this._isCreating = false;
      notifyListeners(); //Prosedur standard untuk memberitahu "listener" bahwa ada perubahan
      return resInvalid;
    }
  }

  // _isReading Digunakan untuk menampilkan "loading indicator"
  // Dan juga logic lain yang membutuhkannya
  bool _isReading = false;
  // Getter dari _isReading
  bool get isReading {
    return this._isReading;
  }

  Future<void> read(BuildContext context) async {
    // Tandai "true" agar aplikasi tahu sedang terjadi proses (R)ead
    this._isReading = true;
    final settingData = Provider.of<SettingProvider>(context, listen: false);
    // Susun URL dengan menggunakan variable dari "setting provider" ditambah pattern API kita
    String url =
        "${settingData.setting.apiHost}/perpus-api/booklist/${settingData.setting.userName}";

    // res adalah variable untuk menampung Response dari server
    http.Response res;

    // ada kemungkinan error saat http.get(), jadi gunakan block "try"
    try {
      final resTmp = await http.get(url);
      res = resTmp;
    } catch (e) {
      this._isReading = false;
      throw (e);
    }
    List<BookListModel> bookListData = (json.decode(res.body)["data"]
            as List) // Decode response sebagai "List"
        .map((i) => BookListModel.fromJson(
            i)) // Format "List" agar sesuai dengan BookListModel
        .toList(); // Terakhir, convert agar jadi "List of BookListModel" ( List<BookListModel> )

    // Menyimpan state ke variable _list,
    // ini variable yg akan dibaca oleh component yang membutuhkan daftar buku
    this._list = bookListData;

    // Kembalikan _isReading ke false yang berarti proses (R)ead selesai
    this._isReading = false;

    // notifyListeners() Memberitahukan kepada semua listener bahwa ada perubahan di provider ini
    notifyListeners();
  }
}
