
import 'package:flutter/material.dart';
import 'package:treat_yoself/routes.dart';
import 'package:get/get.dart';



class Bot_Nav_Bar extends StatelessWidget{

    @override
    Widget build(BuildContext context){
    return BottomAppBar(
        color: Colors.white,
        child: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Get.to(HomeUI());
            }));
    }
}