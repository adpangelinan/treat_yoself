import 'package:treat_yoself/controllers/controllers.dart';

import '../utils/database/db_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import '../utils/entities/shoppinglist.dart';
import '../utils/entities/shoppingitem.dart';
import '../controllers/auth_controller.dart';
import 'dart:convert';

class ShoppingListController extends GetxController {
  var shoppingLists = List<sList>().obs;
  sList currentList;
  TextEditingController addListController = TextEditingController();

  @override
  void onInit() {
    addListController = TextEditingController();

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
            value[i][1].toString(),
            value[i][2].toString(),
            value[i][3].toString(),
            null);
        shoppingLists.add(newList);
      }
    });
    //set current list to null
    setList(null);
  }

  //Sets active shopping list for purposes of pulls when looking at the current shopping cart
  void setList(sList list) {
    print("set list called with $list");
    currentList = list;
  }

  void addList(BuildContext context, String fuid) async {
    //Initialize db
    print("in add list");
    final dbEngine = new DatabaseEngine();
    //get list name from controller
    String name = addListController.text.trim();
    addListController.clear();
    //get correct userID;
    var userQuery = "SELECT UserID FROM Users WHERE Users.fuid = ?;";
    var result = await dbEngine.manualQuery(userQuery, [fuid]);

    String userID = result[0][0].toString();

    //TODO, need to change db so items aren't as critical
    var query2 =
        "INSERT INTO `athdy9ib33fbmfvk`.`ShoppingLists` (`UserID`,  `ListName`) VALUES (?,  ?);";
    await dbEngine.manualQuery(query2, [userID, name]);

    String listID = dbEngine.insertID.toString();
    sList newList = new sList(listID, name, userID, fuid, null);
    shoppingLists.add(newList);
    return;
  }

  void deleteList(String listID) async {
    print("Deleting list $listID");
    deleteListByID(listID);
    int deleteIndex = _getUserListIndex(listID);
    if (deleteIndex > -1) {
      shoppingLists.removeAt(deleteIndex);
    } else {
      print("Error, list does not exist");
    }
  }

  /*Used to pull shopping lists for a particular user using their firestoreUserId */
  List<sList> getUserLists(String fuid) {
    //  print("getting user lists, fuid: $fuid");
    List<sList> userLists = [];
    for (int i = 0; i < shoppingLists.length; i++) {
      //    print("${shoppingLists[i].fuid} comparing $fuid");
      if (shoppingLists[i].fuid == fuid) {
        //Add shopping list items to the user list
        print("getting list items for ${shoppingLists[i].listID}");
        getListItems(shoppingLists[i], i);
        userLists.add(shoppingLists[i]);
      }
    }
    // print(userLists);
    return userLists;
  }

  int _getUserListIndex(String listID) {
    for (int i = 0; i < shoppingLists.length; i++) {
      if (shoppingLists[i].listID == listID) {
        return i;
      }
    }
    return -1;
  }

  /*Adds the items from the database into the shopping list in controller when called*/
  void getListItems(sList shoppinglist, int index) {
    List<ShoppingItem> newItemList = [];
    getListItemsByID(shoppinglist.listID).then((value) {
      print("getting items length is ${value.length}");
      for (var i = 0; i < value.length; i++) {
        print("adding items is ${value[i]}");
        ShoppingItem newItem = new ShoppingItem(
            value[i][0].toString(), //itemID
            value[i][1].toString(), //name
            value[i][2].toString(), //brand
            value[i][3].toString(), //description
            0.0, //price - TODO add into query
            value[i][5]); //quantity
        newItemList.add(newItem);
        //     print("name is ${newItemList[i].name}");

      }
    });
    shoppingLists[index].items = newItemList;
    print("Added list ${shoppingLists[index].name}");
    print("Items is ${shoppingLists[index].items}");
    //print("name of first item is ${shoppingLists[index].items[0].name}");
  }
}

Future<List<dynamic>> fetchAllShoppingLists() async {
  final dbEngine = new DatabaseEngine();
  var query =
      "SELECT ShoppingLists.ListID, ShoppingLists.ListName, ShoppingLists.UserID, Users.fuid FROM ShoppingLists INNER JOIN Users ON Users.UserID = ShoppingLists.UserID;";
  var results = await dbEngine.manualQuery(query);

  return results;
}

Future deleteListByID(String listID) async {
  final dbEngine = new DatabaseEngine();
  var query =
      "DELETE FROM `athdy9ib33fbmfvk`.`ShoppingLists` WHERE (`ListID` = ?);";
  var results = await dbEngine.manualQuery(query, [listID]);
}

Future getListItemsByID(String listID) async {
  final dbEngine = new DatabaseEngine();
  var querySel =
      "SELECT Items.ItemID, Items.Name, Brands.Name, Items.Description, ListItems.Quantity";
  var queryFrom = " FROM athdy9ib33fbmfvk.ListItems";
  var queryJoin1 = " JOIN Items on Items.ItemID = ListItems.ItemID";
  var queryJoin2 =
      " LEFT JOIN BrandsItems on Items.ItemID = BrandsItems.ItemID";
  var queryJoin3 = " LEFT JOIN Brands on BrandsItems.BrandID = Brands.BrandID";
  var queryWher = " WHERE ListItems.ListID = ?;";
  var query =
      querySel + queryFrom + queryJoin1 + queryJoin2 + queryJoin3 + queryWher;
  print(query);
  var results = await dbEngine.manualQuery(query, [listID]);

  return results;
}
