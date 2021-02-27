import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:treat_yoself/routes.dart';
import 'package:treat_yoself/views/views.dart';
import 'package:get/get.dart';

class SideDrawer extends StatelessWidget {
  final AuthController controller = Get.find();
  SideDrawer({Key key}) : super(key: key);
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
              child: Avatar(controller.firestoreUser.value),
            ),
          ),
          ListTile(
            //leading: SongsTab.androidIcon,
            title: Text('Profile'),
            onTap: () {
              Get.to(AccountDetails());
            },
          ),
          ListTile(
            //leading: NewsTab.androidIcon,
            title: Text('Shopping List'),
            onTap: () {
              Get.to(ListOverviewUI());
            },
          ),
          ListTile(
            //leading: ProfileTab.androidIcon,
            title: Text('Find Items'),
            onTap: () {
              //Get.to(ItemSearchTab());
            },
          ),
          ListTile(
            //leading: SettingsTab.androidIcon,
            title: Text("Shop Categories"),
            onTap: () {
              Get.to(Category());
            },
          ),
          ListTile(
            //leading: SettingsTab.androidIcon,
            title: Text("Add Item"),
            onTap: () {
              Get.to(MyCustomForm());
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
              Get.to(SettingsUI());
            },
          ),
        ],
      ),
    );
  }
}
