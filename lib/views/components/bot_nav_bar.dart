import 'package:flutter/material.dart';
import 'package:treat_yoself/routes.dart';
import 'package:get/get.dart';

class BotNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.lightGreen,
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: IconButton(
          icon: Icon(Icons.home, color: context.theme.iconTheme.color),
          onPressed: () {
            Get.offAll(HomeUI());
          }),
    );
  }
}
