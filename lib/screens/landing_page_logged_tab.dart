import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/drawer.dart';

/*Class Landing Paged Logged
Landing Page for a user that is currently logged in
 */
class LandingPageLogged extends StatefulWidget {
  @override
  _LandingPageLogged createState() => _LandingPageLogged();
  static String routeName = '/landing_page';
}

class _LandingPageLogged extends State<LandingPageLogged> {
  void _pushRoute() {
    Navigator.pushReplacementNamed(context, '/landing_page');
  }

  Widget build(BuildContext context) {
    //build a news feed list
    return Scaffold(
      appBar: AppBar(title: Text('Treat Yo Self'), actions: [
        IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/shoppinglist');
            }),
        IconButton(
            icon: Icon(Icons.camera_alt_outlined),
            onPressed: () {
              //TODO: Camera page and route
            }),
      ]),
      drawer: SideDrawer(),
      body: Feed(),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: IconButton(icon: Icon(Icons.home), onPressed: _pushRoute)),
    );

    //body: _,
  }


  void _pushRouteOptions() {
    Navigator.pushReplacementNamed(context, '/option');
  }
}

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
