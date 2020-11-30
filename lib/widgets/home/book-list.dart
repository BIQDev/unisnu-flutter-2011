import 'package:flutter/material.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: 1,
      itemBuilder: (ctx, i) => Text("Dummy"),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 8 / 7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
