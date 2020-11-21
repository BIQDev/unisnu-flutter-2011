import 'package:flutter/material.dart';
import 'package:perpus/providers/setting_provider.dart';
import 'package:provider/provider.dart';

import 'package:perpus/providers/booklist_provider.dart';
import 'package:perpus/widgets/home/book-list-item.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    final settingData = Provider.of<SettingProvider>(context);
    final bookListData = Provider.of<BookListProvider>(context);
    final bookList = bookListData.list;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: bookList.length,
      itemBuilder: (ctx, i) => BookListItem(
        apiHost: settingData.setting.apiHost,
        id: bookList[i].id,
        title: bookList[i].title,
        imagePath: bookList[i].imagePath,
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
