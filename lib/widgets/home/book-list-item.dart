import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.asset(
        "assets/mock/book.png",
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
        title: Text("Judul buku"),
        trailing: IconButton(
          splashColor: Colors.red[100],
          icon: Icon(Icons.favorite),
          onPressed: () {},
        ),
      ),
    );
  }
}
