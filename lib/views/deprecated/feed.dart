import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final _suggestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildTiles(),
    );
  }

  Widget _buildTiles() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _returnTiles(); /*4*/
          }
          return _returnTiles();
        });
  }

  Widget _returnTiles() {
    final leftSection = new Container(
      child: new CircleAvatar(
        backgroundImage: new NetworkImage('https://picsum.photos/250?image=9'),
        backgroundColor: Colors.lightGreen,
        radius: 24.0,
      ),
    );
    final middleTile = new Expanded(
        child: Container(
            padding: EdgeInsets.only(left: 8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Text(
                    "Name",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    "Vons is such a lit store!",
                    style: TextStyle(color: Colors.grey),
                  )
                ])));

    final rightSection = new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Text(
            "9:50",
            style: new TextStyle(color: Colors.lightGreen, fontSize: 12.0),
          ),
          new CircleAvatar(
            backgroundColor: Colors.lightGreen,
            radius: 10.0,
            child: new Text(
              "2",
              style: new TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          )
        ],
      ),
    );

    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      height: 70.0,
      child: new Row(
        children: <Widget>[leftSection, middleTile, rightSection],
      ),
    );
  }
}
