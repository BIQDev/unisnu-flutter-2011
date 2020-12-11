import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:perpus/widgets/home/book-list-item.dart';
import 'package:perpus/models/booklist_model.dart';
import 'package:perpus/providers/booklist_provider.dart';
import 'package:perpus/providers/setting_provider.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    var apiHost =
        Provider.of<SettingProvider>(context, listen: false).setting.apiHost;
    List<BookListModel> bookList = context.watch<BookListProvider>().list;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: bookList.length,
      itemBuilder: (ctx, i) => BookListItem(
        id: bookList[i].id,
        apiHost: apiHost,
        imagePath: bookList[i].imagePath,
        title: bookList[i].title,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 8 / 7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
