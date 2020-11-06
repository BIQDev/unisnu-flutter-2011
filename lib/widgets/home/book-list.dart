import 'package:flutter/material.dart';
import 'package:perpus/widgets/home/book-list-item.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 8 / 7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: <Widget>[
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
          BookListItem(),
        ],
      ),
    );
  }
}
