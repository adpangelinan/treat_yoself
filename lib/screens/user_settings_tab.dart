import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treat_yoself/utils/entities/authentication_service.dart';
import '../components/drawer.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSettings extends StatelessWidget {
  static String routeName = '/user_settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 50),
                Text('Place to Change User Settings'),
                SizedBox(height: 50),
                RaisedButton(
                    child: Text('Go back to landing page'),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/landing_page');
                    }),
                RaisedButton(
                    child: Text('Log out'),
                    onPressed: () {
                      final AuthenticationService _auth =
                          AuthenticationService(FirebaseAuth.instance);
                      _auth.signOut();
                      Navigator.pushReplacementNamed(context, '/login');
                    }),
              ],
            )),
      ),
    );
  }
}
