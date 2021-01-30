import 'dart:async';
import 'package:treat_yoself/screens/shoppinglist_tab.dart';
import 'utils/database/db_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treat_yoself/routes.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';

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
      title: 'Treat Yoself!',
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
        LandingPageLogged.routeName: (context) => LandingPageLogged(),
        Login.routeName: (context) => Login(),
        ShoppingList.routeName: (context) => ShoppingList(),
        Registration.routeName: (context) => Registration(),
        ItemSearch.routeName: (context) => ItemSearch(),
        UserSettings.routeName: (context) => UserSettings(),
        Category.routeName: (context) => Category(),
      },
      initialRoute: Login.routeName,
    );
  }
}
