import 'package:flutter/material.dart';

import 'package:perpus/screens/book-input.dart';
import 'package:perpus/screens/home-page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
        BookInputScreen.routeName: (ctx) => BookInputScreen(),
      },
    );
  }
}
