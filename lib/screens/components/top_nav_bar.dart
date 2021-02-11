import 'package:flutter/material.dart';
import 'package:treat_yoself/routes.dart';
import 'package:get/get.dart';
import 'package:treat_yoself/localizations.dart';

class TopNavBar extends StatelessWidget {
  TopNavBar({Key key});
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return AppBar(
      title: Text(labels?.home?.title),
      actions: [
        IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              //Get.to(ShoppingCart());
            }),
        IconButton(
            icon: Icon(Icons.camera_alt_outlined),
            onPressed: () {
              //Get.to(CameraPage());
            }),
        IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.to(SettingsUI());
            }),
      ],
    );
  }
}
