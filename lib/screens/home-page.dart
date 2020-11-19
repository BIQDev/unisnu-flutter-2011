import 'package:flutter/material.dart';
import 'package:perpus/screens/book-add.dart';
import 'package:perpus/widgets/home/book-list.dart';
import 'package:perpus/widgets/home/header.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            {Navigator.of(context).pushNamed(BookAddScreen.routeName)},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
