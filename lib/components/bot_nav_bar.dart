import 'package:flutter/material.dart';

class Bot_Nav_Bar extends StatelessWidget implements PreferredSizeWidget {
  Bot_Nav_Bar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Colors.white,
        child: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/landing_page');
            }));
  }
}
