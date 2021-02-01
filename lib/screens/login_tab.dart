import 'package:flutter/material.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';
import '../components/drawer.dart';

class Login extends StatefulWidget {
  static String routeName = '/';
  const Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //final dbEngine = DatabaseEngine().initialize();
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
                  hintText: 'Username',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
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
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text('Sign In'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    Navigator.pushReplacementNamed(context, '/landing_page');
                  }
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
