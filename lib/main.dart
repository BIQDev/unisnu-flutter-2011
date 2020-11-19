import 'package:flutter/material.dart';
import 'package:perpus/screens/book-input.dart';
import 'package:provider/provider.dart';

import 'package:perpus/screens/home-page.dart';
import 'package:perpus/providers/booklist_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookListProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        routes: {
          BookInputScreen.routeName: (ctx) => BookInputScreen(),
        },
      ),
    );
  }
}
