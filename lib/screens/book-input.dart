import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

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
                RaisedButton(
                  child: Text("Simpan"),
                  color: Colors.lightBlueAccent,
                  onPressed: !this._inputIsValid ? null : () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
