import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static String routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline3,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text('ENTER'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/landing_page');
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
    );
  }
}
