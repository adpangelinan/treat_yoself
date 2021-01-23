import 'dart:async';
import 'package:treat_yoself/screens/shoppinglist_tab.dart';

import 'utils/db_utils.dart';
import 'package:flutter/material.dart';
import 'package:treat_yoself/routes.dart';

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
