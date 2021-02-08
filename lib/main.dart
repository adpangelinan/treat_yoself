import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:treat_yoself/screens/search_results_tab.dart';
import 'package:treat_yoself/screens/shoppinglist_tab.dart';
import 'package:treat_yoself/utils/entities/authentication_service.dart';
import 'package:treat_yoself/utils/entities/user.dart';
import 'utils/database/db_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treat_yoself/routes.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

/*Page/Structure Classes Section*/
/*
Main App
 */

class App extends StatelessWidget {
  // This widget is the root of your application.
  User user;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
              create: (_) => AuthenticationService(FirebaseAuth.instance)),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
          )
        ],
        child: MaterialApp(
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
            LoginPage.routeName: (context) => LoginPage(),
            ShoppingList.routeName: (context) => ShoppingList(),
            Registration.routeName: (context) => Registration(),
            ItemSearch.routeName: (context) => ItemSearch(),
            UserSettings.routeName: (context) => UserSettings(),
            Category.routeName: (context) => Category(),
            Results.routeName: (context) => Results(),
          },
          home: AuthenticationWrapper(),
        ));
  }
}

class AuthenticationWrapper extends StatelessWidget {
  static const user = 153;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return LandingPageLogged(user: user);
    } else {
      return LoginPage();
    }
  }
}
