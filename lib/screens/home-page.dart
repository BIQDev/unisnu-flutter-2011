import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:perpus/screens/book-input.dart';
import 'package:perpus/widgets/home/book-list.dart';
import 'package:perpus/widgets/home/header.dart';
import 'package:perpus/providers/booklist_provider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  _newBook(BuildContext addButtonContext) async {
    final result = await Navigator.of(addButtonContext).pushNamed(
      BookInputScreen.routeName,
    );

    if (result == 200) {
      Scaffold.of(addButtonContext)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text("Berhasil menambah buku"),
            backgroundColor: Colors.greenAccent.shade700,
          ),
        );
      addButtonContext.read<BookListProvider>().read(addButtonContext);
    }
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
