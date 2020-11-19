import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class BookListItem extends StatelessWidget {
  @required
  final String id;
  @required
  final String title;
  @required
  final String imagePath;

  BookListItem({this.id, this.title, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.asset(
        this.imagePath,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
      header: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            splashColor: Colors.orange[100],
            color: Colors.deepOrangeAccent,
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            color: Colors.redAccent,
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(this.title),
        trailing: IconButton(
          splashColor: Colors.red[400],
          icon: Icon(Icons.favorite),
          onPressed: () {},
        ),
      ),
    );
  }
}
