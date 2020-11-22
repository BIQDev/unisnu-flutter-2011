import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mime/mime.dart';

import 'package:perpus/providers/setting_provider.dart';

class BookInputScreenArguments {
  final String id;
  final String title;
  final String imagePath;
  BookInputScreenArguments({this.id, this.title, this.imagePath});
}

class BookInputScreen extends StatefulWidget {
  static const routeName = "/book-add";

  @override
  _BookInputScreenState createState() => _BookInputScreenState();
}

class _BookInputScreenState extends State<BookInputScreen> {
  String _title;
  bool _inputIsValid = false;
  bool _isInitialized;
  BookInputScreenArguments _args;

  String _apiHost = "";
  String _userName = "";

  File _image;
  final picker = ImagePicker();

  Future _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

        this._setInputValid();
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void didChangeDependencies() {
    if (this._isInitialized == null || this._isInitialized) {
      this._args = ModalRoute.of(context).settings.arguments;
      SettingProvider settingData =
          Provider.of<SettingProvider>(context, listen: false);
      this._apiHost = settingData.setting.apiHost;
      this._userName = settingData.setting.userName;
      if (this._args != null && this._args.id != null) {
        this._title = this._args.title;
      }

      this._setInputValid();
      this._isInitialized = true;
    }
    super.didChangeDependencies();
  }

  void _setInputValid() {
    this._inputIsValid =
        this._title != null && this._title != "" && this._image != null;
  }

  bool get inputIsValid {
    return this._inputIsValid;
  }

  Future<void> _submit(BuildContext submitContext) async {
    if (!this.inputIsValid) {
      return;
    }

    List mimeStr = lookupMimeType(this._image.path).split("/");

    var imageBytes = await this._image.readAsBytes();
    var uri =
        Uri.parse('${this._apiHost}/perpus-api/booklist/${this._userName}');
    var request = http.MultipartRequest('POST', uri)
      ..fields['title'] = this._title
      ..files.add(http.MultipartFile.fromBytes('image', imageBytes,
          filename: path.basename(this._image.path),
          contentType: MediaType(mimeStr[0], mimeStr[1])));
    try {
      http.StreamedResponse res = await request.send();
      final String respStr = await res.stream.bytesToString();
      Map<String, dynamic> resDecoded = json.decode(respStr);
      if (res.statusCode == 200) {
        Navigator.pop(context, res.statusCode);
      } else {
        Scaffold.of(submitContext).showSnackBar(
            SnackBar(content: Text("Error:${resDecoded["message"]}")));
      }
    } catch (e) {
      Scaffold.of(submitContext)
          .showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: this._args == null || this._args.id == null
            ? const Text("Tambah Buku")
            : const Text("Edit Buku"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  initialValue: this._title,
                  onChanged: (v) {
                    setState(() {
                      this._title = v;
                      this._setInputValid();
                    });
                  },
                ),
                SizedBox(height: 10),
                FlatButton.icon(
                  icon: Icon(Icons.image),
                  onPressed: _pickImage,
                  label: Text("Pick an Image"),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: this._image == null
                      ? Container()
                      : Image(
                          image: FileImage(this._image),
                          width: 230,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(height: 10),
                Builder(builder: (BuildContext submitContext) {
                  return RaisedButton(
                    child: Text("Simpan"),
                    color: Colors.lightBlueAccent,
                    onPressed: !this.inputIsValid
                        ? null
                        : () {
                            this._submit(submitContext);
                          },
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
