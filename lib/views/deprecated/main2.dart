/*
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:treat_yoself/screens/search_results_tab.dart';
import 'package:treat_yoself/screens/shoppinglist_tab.dart';
import 'package:treat_yoself/utils/entities/authentication_service.dart';
import 'package:treat_yoself/utils/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treat_yoself/routes.dart';
import 'dart:convert';

Future<void> main2() async {
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
            ShoppingTripGen.routeName: (context) => ShoppingTripGen(),
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
    print(firebaseUser);
    if (firebaseUser != null) {
      return LandingPageLogged(user: user);
    } else {
      return LoginPage();
    }
  }

  Future<UserData> fetchUserData(
      AuthenticationService authenticationService) async {
    DatabaseEngine dbEngine = DatabaseEngine();
    var email = authenticationService.getEmail();
    var results = await dbEngine.manualQuery(
        "SELECT * FROM athdy9ib33fbmfvk.Users WHERE Email = ?;", [email]);
    if (results.length > 0) {
      var user = UserData.fromJson(json.decode(results[0].toString()));
      return user;
    } else {
      //Create a new user object if there isn't one for some reason.
    }
  }
}
*/
