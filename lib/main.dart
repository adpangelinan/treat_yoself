import 'dart:async';
import 'utils/db_utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

/*Page/Structure Classes Section*/
/*
Main App
 */
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPageLogged(title: 'Landing Page'),
    );
  }
}

/*Class Landing Paged Logged
Landing Page for a user that is currently logged in
 */
class LandingPageLogged extends StatefulWidget {
  LandingPageLogged({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LandingPageLoggedState createState() => _LandingPageLoggedState();
}

class _LandingPageLoggedState extends State<LandingPageLogged> {
  List<String> dbData;

  @override
  void initState() {
    _setData();
    super.initState();
  }

  void _setData() async {
    dbData = await queryDB();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 12),
            itemBuilder: (BuildContext ctxt, int index) {
              return new Text(dbData[index]);
            }));
  }
}

class UnloggedLandingPage extends StatefulWidget {
  @override
  _UnloggedLandingPageState createState() => _UnloggedLandingPageState();
}

class _UnloggedLandingPageState extends State<UnloggedLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FindItems extends StatefulWidget {
  @override
  _FindItemsState createState() => _FindItemsState();
}

class _FindItemsState extends State<FindItems> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/********************************************************/
// CONTROLLERS AND OBJECT CLASSES SECTION
/*********************************************************/

/*class Database Controller
Controls interactions with the database
 */
class DatabaseController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ShoppingTripGen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/*Item Object*/
class Item extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/* Store Object

 */
class Store extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/*
Category Object
 */
class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/*
Brand Object
 */
class Brand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
