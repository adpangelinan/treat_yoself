import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'login_tab.dart';


/*Class Landing Paged Logged
Landing Page for a user that is currently logged in
 */
class LandingPageLogged extends StatefulWidget {
  @override
  _LandingPageLogged createState() => _LandingPageLogged(); 
  static String routName = '/landing_page';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


 
}

class _LandingPageLogged extends State<LandingPageLogged>{
  _onpush(){
     Navigator.pushReplacementNamed(context, '/shoppinglist');
  }
  

  Widget build(BuildContext context){  //build a news feed list 
    return Scaffold(
      appBar: AppBar(
        title: Text('Treat Yo Self'),
          actions: [IconButton(icon: Icon(Icons.shopping_cart), onPressed:  null)]),
        drawer: _returnDrawer()
    ,
    body:  Feed(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white ,
        child: IconButton(icon: Icon(Icons.home), onPressed: _pushRoute)),
        
    );

      //body: _,
  }

Widget _returnDrawer(){
  return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Icon(
                Icons.account_circle,
                color: Colors.green.shade800,
                size: 96,
              ),
            ),
          ),
          ListTile(
            //leading: SongsTab.androidIcon,
            title: Text('Profile'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            //leading: NewsTab.androidIcon,
            title: Text('Shopping List'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            //leading: ProfileTab.androidIcon,
            title: Text('Find Items'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          // Long drawer contents are often segmented.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            
          ),
          ListTile(
            //leading: SettingsTab.androidIcon,
            title: Text("Settings"),
            onTap: () {
               Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
  );

  }

  void _pushRoute(){
    Navigator.pushReplacementNamed(context, '/landing_page');
  }

  void _pushRouteOptions(){
    Navigator.pushReplacementNamed(context, '/option');
    
  }



}


class Feed extends StatefulWidget{
  @override 
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed>{
    final _suggestions = [];

@override
Widget build(BuildContext context){
  return Scaffold(
    body: _buildTiles(),
  );

}


Widget _buildTiles(){
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


Widget _returnTiles(){
  final leftSection = new Container(
    child: new CircleAvatar(
      backgroundImage: new NetworkImage('https://picsum.photos/250?image=9'),
      backgroundColor: Colors.lightGreen,
      radius: 24.0,
    ),
  );
  final middleTile = new Expanded(
    child: Container (
      padding : EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Text("Name",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),),
          Text("Vons is such a lit store!", style: 
            TextStyle(color: Colors.grey),)
        ]
      )
    )
  );

final rightSection = new Container(
  child: new Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      new Text("9:50",
          style: new TextStyle(
            color: Colors.lightGreen,
          fontSize: 12.0),),
      new CircleAvatar(
        backgroundColor: Colors.lightGreen,
        radius: 10.0,
        child: new Text("2",
        style: new TextStyle(color: Colors.white,
        fontSize: 12.0),),
      )
    ],
  ),
);

  return 
    new Container(
      padding: new EdgeInsets.symmetric(vertical:10.0,
      horizontal: 8.0),
      height: 70.0,
      child: new Row(
        children: <Widget>[
          leftSection,
          middleTile,
          rightSection
        ],
      ),
    );



}
 




}
