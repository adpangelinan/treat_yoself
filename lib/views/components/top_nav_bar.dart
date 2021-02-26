import 'package:flutter/material.dart';
import 'package:treat_yoself/routes.dart';
import 'package:get/get.dart';
import 'package:treat_yoself/views/views.dart';

class TopNavBar extends StatelessWidget implements PreferredSize {
  Size get preferredSize => const Size.fromHeight(50.0);
  final title;
  TopNavBar({Key key, this.title});
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(ShoppingTripGen());
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
        IconButton(
          icon: Icon(Icons.comment), 
          onPressed: () {Get.to(Comment());})
      ],
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
