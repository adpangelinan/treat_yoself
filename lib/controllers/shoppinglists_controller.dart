import '../utils/database/db_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import '../utils/entities/shoppinglist.dart';
import '../controllers/auth_controller.dart';
import 'dart:convert';

class ShoppingListController extends GetxController {
  var shoppingLists = List<sList>().obs;
  TextEditingController addTaskController;
  AuthController user;

  @override
  void onInit() {
    addTaskController = TextEditingController();

    _getData();
    super.onInit();
  }

  /*When Controller is initialized, grabs every single shopping list in db and 
  converts to sList items */
  void _getData() {
    fetchAllShoppingLists().then((value) {
      for (var i = 0; i < value.length; i++) {
        sList newList = new sList(
            value[i][0].toString(),
            value[i][3].toString(),
            value[i][1].toString(),
            value[i][4].toString(),
            null);
        shoppingLists.add(newList);
      }
    });
  }

  /*Used to pull shopping lists for a particular user using their firestoreUserId */
  List<sList> getUserLists(String fuid) {
    List<sList> userLists = [];
    for (int i = 0; i < shoppingLists.length; i++) {
      if (shoppingLists[i].fuid == fuid) {
        userLists.add(shoppingLists[i]);
      }
    }
    return userLists;
  }
}

Future<List<dynamic>> fetchAllShoppingLists() async {
  final dbEngine = new DatabaseEngine();
  var query =
      "SELECT ShoppingLists.ListID, ShoppingLists.UserID, ShoppingLists.ItemID, ShoppingLists.ListName, Users.fuid FROM ShoppingLists INNER JOIN Users ON Users.UserID = ShoppingLists.UserID;";
  var results = await dbEngine.manualQuery(query);

  return results;
}

/*
Future<List<sList>> fetchShoppingLists() async {
    List<sList> userShoppingLists = new List<sList>();
    var query =
        "SELECT ShoppingLists.ListName as ListName FROM ShoppingLists JOIN Users ON Users.UserID = ShoppingLists.UserID JOIN Items ON Items.ItemID = ShoppingLists.ItemID WHERE Users.UserID = ?;";
    var results = await dbEngine.manualQuery(query, [widget.user]);

    if (results.length > 0) {
      for (var i = 0; i < results.length; i++) {
        sList newList = new sList(0, results[i], "Adrian", null);
        print(newList.name);
        userShoppingLists.add(newList);
      }
    } else {
      print("no user shopping lists found");
    }
    return userShoppingLists;
  }
*/
