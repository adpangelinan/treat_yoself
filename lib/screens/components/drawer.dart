import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:treat_yoself/routes.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key key, @required this.user}) : super(key: key);
  final int user;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Icon(
                Icons.account_circle,
                color: Colors.green.shade800,
                size: 96,
              ),
            ),
          ),
          ListTile(
            //leading: SongsTab.androidIcon,
            title: Text('Profile'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/user_settings');
            },
          ),
          ListTile(
            //leading: NewsTab.androidIcon,
            title: Text('Shopping List'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingList(
                      user: user,
                    ),
                  ));
            },
          ),
          ListTile(
            //leading: ProfileTab.androidIcon,
            title: Text('Find Items'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemSearch(
                      user: user,
                    ),
                  ));
            },
          ),
          ListTile(
            //leading: SettingsTab.androidIcon,
            title: Text("Shop Categories"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Category(
                      user: user,
                    ),
                  ));
            },
          ),
          // Long drawer contents are often segmented.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          ListTile(
            //leading: SettingsTab.androidIcon,
            title: Text("Settings"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserSettings(
                      user: user,
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
