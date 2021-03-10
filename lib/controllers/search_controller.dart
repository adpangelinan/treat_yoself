import 'package:treat_yoself/controllers/controllers.dart';
import '../utils/database/db_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import '../utils/entities/shoppingitem.dart';
import '../controllers/auth_controller.dart';
import 'dart:convert';
import 'dart:math';

class SearchController extends GetxController {
  var foundArr = List<SearchItem>().obs;
  var items = List<SearchItem>();
  ShoppingListController listController = Get.find();
  bool searchHasResults;
  TextEditingController searchTextBox = TextEditingController();

  @override
  void onInit() {
    _getData();
    searchHasResults = true;
    super.onInit();
  }

  /* when controller is initialized, grabs all rewards*/
  void _getData() {
    print("fetching data for search");
    fetchAllItems().then((value) {
      print("received data for search");
      print("$value");
      for (var i = 0; i < value.length; i++) {
        SearchItem newSearchItem = new SearchItem(
            value[i][0], //itemID
            value[i][1].toString(), //name
            null //LevDistance
            );
        items.add(newSearchItem);
      }
    });
  }

  //populates items with lev distance
  // adds items that match search string in foundArr
  List<SearchItem> search() {
    searchHasResults = true;
    foundArr.clear();
    String searchStr = searchTextBox.text.trim();
    print("searching for $searchStr");
    searchTextBox.clear();
    int maxDistance = searchStr.length;

    items.forEach((item) {
      item.levDistance = levenShteinDistance(searchStr, item.name);
      // print("comp ${item.name}:$searchStr lev:${item.levDistance}");

      if (item.levDistance <= 2) {
        foundArr.add(item);
      }
    });
    //if no items of levDistance <= 2 found, will add items until distance is 2 less than max distance

    if (foundArr.isEmpty) {
      int distance = 3;
      while (distance < 4) {
        items.forEach((item) {
          if (item.levDistance <= distance) {
            if (!foundArr.contains(item)) {
              foundArr.add(item);
            }
          }
        });
        distance += 1;
      }
    }

    print("search completed, results:");
    if (foundArr.isNotEmpty) {
      searchHasResults = true;
    } else {
      searchHasResults = false;
    }
    return foundArr;
  }

  //clears search
  void clearSearch() {
    foundArr.clear();
    searchHasResults = true;
  }

  Future addItem(String itemID) async {
    //returns 0 if successful, returns 1 if current list was null
    var successful = await listController.addItemToCurrent(itemID);
    return successful;
  }
}

//db queries
Future<List<dynamic>> fetchAllItems() async {
  final dbEngine = new DatabaseEngine();
  var query = "SELECT Items.ItemID, Items.Name FROM athdy9ib33fbmfvk.Items;";

  var results = await dbEngine.manualQuery(query);

  return results;
}

/*Calculates the levenshtein distance between string a and string b,
used for search function*/
int levenShteinDistance(String a, String b) {
  int rows = a.length + 1;
  int cols = b.length + 1;

  a = a.toLowerCase();
  b = b.toLowerCase();

  var arr =
      List<List<int>>.generate(rows, (i) => List<int>(cols), growable: false);

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      arr[i][j] = 0;
    }
  }

  for (int i = 1; i < rows; i++) {
    arr[i][0] = i;
  }

  for (int j = 1; j < cols; j++) {
    arr[0][j] = j;
  }
  int substitutionCost;
  for (int j = 1; j < cols; j++) {
    for (int i = 1; i < rows; i++) {
      //   print("i:$i j:$j comparing ${a[i - 1]} : ${b[j - 1]}");
      if (a[i - 1] == b[j - 1]) {
        substitutionCost = 0;
      } else {
        substitutionCost = 1;
      }
      arr[i][j] = [
        arr[i - 1][j] + 1,
        arr[i][j - 1] + 1,
        arr[i - 1][j - 1] + substitutionCost
      ].reduce(min);
    }
  }
  /*
  for (int i = 0; i < rows; i++) {
    print("Lev Row $i is ${arr[i]}");
  }
  */
  return arr[rows - 1][cols - 1];
}

class SearchItem {
  int itemID;
  String name;
  int levDistance;

  SearchItem(this.itemID, this.name, this.levDistance);
}
