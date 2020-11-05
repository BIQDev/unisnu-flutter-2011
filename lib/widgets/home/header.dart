import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          "assets/icon/icon-710x710-android.png",
          width: 100,
          height: 100,
        ),
        Column(
          children: <Widget>[
            Text(
              "Perpus",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "by UNISNU",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ],
    );
  }
}
