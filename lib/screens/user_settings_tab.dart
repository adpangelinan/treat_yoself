import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              ],
            )),
      ),
    );
  }
}
