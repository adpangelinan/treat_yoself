import 'package:flutter/material.dart';

class Top_Nav_Bar extends StatelessWidget implements PreferredSizeWidget {
  Top_Nav_Bar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;
  Widget build(BuildContext context) {
    return AppBar(title: Text('Home'), actions: [
      IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.pushNamed(context, '/shopping_list');
          }),
      IconButton(
          icon: Icon(Icons.camera_alt_outlined),
          onPressed: () {
            //TODO: Camera page and route
          }),
      IconButton(icon: Icon(Icons.account_circle), onPressed: () {}),
    ]);
  }
}
