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
  List<BookListModel> _bookList;
  String _apiHost;
  bool _isInitialized;
  bool _isFetching;

  @override
  void didChangeDependencies() {
    final settingData = Provider.of<SettingProvider>(context);
    this._apiHost = settingData.setting.apiHost;
    final bookListData = Provider.of<BookListProvider>(context);
    this._bookList = bookListData.list;
    this._isFetching = bookListData.isFetching;

    if (this._isInitialized == null || !this._isInitialized) {
      bookListData.fetchList(context);
      this._isInitialized = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isFetching = context.watch<BookListProvider>().isFetching;
    return isFetching == null || isFetching
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          )
        : GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: this._bookList == null ? 0 : this._bookList.length,
            itemBuilder: (ctx, i) => BookListItem(
              apiHost: this._apiHost,
              id: this._bookList[i].id,
              title: this._bookList[i].title,
              imagePath: this._bookList[i].imagePath,
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
