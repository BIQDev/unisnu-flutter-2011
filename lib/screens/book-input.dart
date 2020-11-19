import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class BookInputScreen extends StatefulWidget {
  static const routeName = "/book-add";

  @override
  _BookInputScreenState createState() => _BookInputScreenState();
}

class _BookInputScreenState extends State<BookInputScreen> {
  File _image;
  final picker = ImagePicker();
  Future _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Buku"),
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
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
