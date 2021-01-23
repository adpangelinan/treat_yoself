import 'dart:async';
import 'package:treat_yoself/screens/shoppinglist_tab.dart';

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
import './screens/landing_page_logged_tab.dart';
import './screens/login_tab.dart';

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
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        // This is the theme of your application.
        //
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        LandingPageLogged.routName: (context) => LandingPageLogged(),
        Login.routeName: (context) => Login(),
        ShoppingList.routeName: (context) => ShoppingList(), 
      },
      initialRoute: Login.routeName,
    );
  }
}

/*Class Landing Paged Logged
Landing Page for a user that is currently logged in
 */

