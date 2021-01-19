import 'dart:async';
import 'utils/db_utils.dart';
import 'package:flutter/material.dart';
import './screens/brand_tab.dart';
import './screens/category_tab.dart';
import './screens/database_controller_tab.dart';
import './screens/item_tab.dart';
import './screens/login_tab.dart';
import './screens/registration_tab.dart';
import './screens/shopping_tripgen_tab.dart';
import './screens/store_tab.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
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
