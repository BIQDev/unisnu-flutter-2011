import 'package:flutter/material.dart';
import 'package:perpus/models/booklist_model.dart';
import 'package:perpus/providers/setting_provider.dart';
import 'package:provider/provider.dart';

import 'package:perpus/providers/booklist_provider.dart';
import 'package:perpus/widgets/home/book-list-item.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  String _apiHost;
  bool _isInitialized;

  @override
  void didChangeDependencies() {
    this._apiHost = context.read<SettingProvider>().setting.apiHost;

    if (this._isInitialized == null || !this._isInitialized) {
      context.read<BookListProvider>().read(context);
      this._isInitialized = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isReading = context.watch<BookListProvider>().isReading;
    List<BookListModel> bookList = context.watch<BookListProvider>().list;

    return isReading == null || isReading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          )
        : GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: bookList == null ? 0 : bookList.length,
            itemBuilder: (ctx, i) => BookListItem(
              apiHost: this._apiHost,
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
