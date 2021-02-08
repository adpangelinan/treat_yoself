import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../components/top_nav_bar.dart';
import '../components/bot_nav_bar.dart';
import 'package:treat_yoself/routes.dart';

class ItemSearch extends StatelessWidget {
  const ItemSearch({Key key, @required this.user}) : super(key: key);
  final int user;
  static String routeName = '/item_search';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Top_Nav_Bar(user: user),
      drawer: SideDrawer(user: user),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LandingPageLogged(
                          user: user,
                        ),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bot_Nav_Bar(user: user),
    );
  }
}
