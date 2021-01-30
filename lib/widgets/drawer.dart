import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SideDrawer extends StatelessWidget {
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
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            //leading: NewsTab.androidIcon,
            title: Text('Shopping List'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/shopping_list');
            },
          ),
          ListTile(
            //leading: ProfileTab.androidIcon,
            title: Text('Find Items'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/item_search');
            },
          ),
          ListTile(
            //leading: SettingsTab.androidIcon,
            title: Text("Shop Categories"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/category');
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
              Navigator.pushReplacementNamed(context, '/user_settings');
            },
          ),
        ],
      ),
    );
  }
}
