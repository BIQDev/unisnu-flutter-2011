import 'package:flutter/material.dart';
import 'package:perpus/screens/book-input.dart';
import 'package:perpus/widgets/home/book-list.dart';
import 'package:perpus/widgets/home/header.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  _newBook(BuildContext addButtonContext) async {
    Navigator.of(addButtonContext).pushNamed(
      BookInputScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            Header(),
            new Expanded(child: BookList()),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (BuildContext addButtonContext) {
          return FloatingActionButton(
            onPressed: () {
              this._newBook(addButtonContext);
            },
            tooltip: 'New Product',
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
