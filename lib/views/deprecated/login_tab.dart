import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:treat_yoself/utils/entities/authentication_service.dart';

/// Eventually refactor using: https://pub.dev/packages/flutter_login#-installing-tab-

class LoginPage extends StatelessWidget {
  static String routeName = '/login';
  var email = '';
  var password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.all(80.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline3,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value) {
                  if (value.isEmpty ||
                      !value.contains('@') ||
                      !value.contains('.')) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
                onChanged: (value) {
                  email = value.trim();
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onChanged: (value) {
                  password = value.trim();
                },
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text('Sign In'),
                onPressed: () {
                  context
                      .read<AuthenticationService>()
                      .signIn(email: email, password: password);
                },
              ),
              SizedBox(
                height: 12,
              ),
              RaisedButton(
                  color: Colors.blueAccent,
                  child: RichText(
                      text: TextSpan(
                    text: 'Register Here',
                    style: TextStyle(color: Colors.white),
                  )),
                  onPressed: () {
                    Navigator.pushNamed(context, '/Registration');
                  }),
            ],
          ),
        ),
      ),
    ));
  }
}
/*
class Login extends StatefulWidget {
  static String routeName = '/login';
  const Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = "";
  var password = "";
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.all(80.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline3,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value) {
                  if (value.isEmpty ||
                      !value.contains('@') ||
                      !value.contains('.')) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
                onChanged: (value) {
                  email = value.trim();
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onChanged: (value) {
                  password = value.trim();
                },
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text('Sign In'),
                onPressed: () {
                  context
                      .read<AuthenticationService>()
                      .signIn(email: email, password: password);
                },
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                  color: Colors.blueAccent,
                  child: RichText(
                      text: TextSpan(
                    text: 'Register Here',
                    style: TextStyle(color: Colors.white),
                  )),
                  onPressed: () {
                    Navigator.pushNamed(context, '/Registration');
                  }),
            ],
          ),
        ),
      ),
    ));
  }
}
*/
