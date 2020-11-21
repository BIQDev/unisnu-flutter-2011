import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perpus/screens/book-input.dart';
import 'package:provider/provider.dart';

import 'package:perpus/screens/home-page.dart';
import 'package:perpus/providers/booklist_provider.dart';
import 'package:perpus/providers/setting_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData bd = await loadCert();
  HttpOverrides.global = new MyHttpOverrides(bd);
  runApp(MyApp());
}

Future<ByteData> loadCert() async {
  return await rootBundle.load('assets/server.pem');
}

class MyHttpOverrides extends HttpOverrides {
  ByteData ctxData;
  MyHttpOverrides(this.ctxData);

  @override
  HttpClient createHttpClient(SecurityContext context) {
    SecurityContext ctx = SecurityContext.defaultContext;
    ctx.setTrustedCertificatesBytes(this.ctxData.buffer.asUint8List());
    return super.createHttpClient(ctx)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookListProvider()),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
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
