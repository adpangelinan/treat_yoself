import 'package:flutter/material.dart';
import 'package:treat_yoself/routes.dart';

class Top_Nav_Bar extends StatelessWidget implements PreferredSizeWidget {
  Top_Nav_Bar({Key key, @required this.user})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);
  final int user;

  @override
  final Size preferredSize;
  Widget build(BuildContext context) {
    return AppBar(title: Text('Home'), actions: [
      IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingList(
                    user: user,
                  ),
                ));
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
