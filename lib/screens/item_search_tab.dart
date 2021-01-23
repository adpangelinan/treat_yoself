import 'package:flutter/material.dart';

class ItemSearch extends StatelessWidget {
  static String routeName = '/item_search';
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
                'Item Search',
                style: Theme.of(context).textTheme.headline5,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'What are you looking for?',
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
