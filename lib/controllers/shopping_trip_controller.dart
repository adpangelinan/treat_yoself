import 'package:treat_yoself/controllers/controllers.dart';
import 'package:treat_yoself/routes.dart';
import '../utils/database/db_utils.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import '../utils/entities/shoppinglist.dart';

class ShoppingTripController extends GetxController {
  final ShoppingListController slController = Get.find();
  final AuthController authController = Get.find();
  final DatabaseEngine dbConn = DatabaseEngine();
  ShoppingList list;
  String listID;
  String userZip;
  String bestStore = "";
  Map<String, dynamic>
      results; // {StoreName: [item, price], StoreName2: [item, price]}
  Map<String, dynamic> missing;
  List<dynamic> rawResults;
  final String lowestPriceQuery =
      "select min(p.Price) as price, s.Name as store, i.Name as item, i.ItemID as itemID from Prices p left join StoresItems si on si.StoreItemID = p.StoreItemID left join BrandsItems bi on si.BrandItemID = bi.BrandItemID left join Items i on i.ItemID = bi.ItemID left join Stores s on s.StoreID = si.StoreID where bi.BrandItemID in (select ItemID from ListItems where ListID = ?) and s.ZipCode = ? group by i.itemID order by price asc ";
  final String singleStoreQuery =
      "select p.Price as price, s.Name as store, i.Name as item, i.ItemID as itemID from Prices p left join StoresItems si on si.StoreItemID = p.StoreItemID left join BrandsItems bi on si.BrandItemID = bi.BrandItemID left join Items i on i.ItemID = bi.ItemID left join Stores s on s.StoreID = si.StoreID where bi.BrandItemID in (select ItemID from ListItems where ListID = ?) and s.ZipCode = ? order by price asc ;";
  static String tripType;
  ShoppingTripController(tripType, [list, listID, userZip]) {
    list = slController.currentList;
    listID = list.listID;
    userZip = authController.firestoreUser.value.zipcode;
    if (tripType == "singleStore") {
      dbConn.manualQuery(singleStoreQuery, [listID, userZip]).then(
          (res) => {_singleStoreTripAlgorithm(res)});
    } else {
      dbConn.manualQuery(lowestPriceQuery, [listID, userZip]).then(
          (res) => {_lowestPriceTripAlgorithm(res)});
    }
  }

  void _lowestPriceTripAlgorithm(rawRes) {
    Map items = Map<String,
        dynamic>(); // {storeName: [[item1, item1price], [item2, item2price]]}
    for (var row in rawRes) {
      items.putIfAbsent(row[1], () => [row[2], row[0]]);
    }
    results = items;
    update();
  }

  void _singleStoreTripAlgorithm(rawRes) {
    Map items = Map<String,
        dynamic>(); // {storeName: [[item1, item1price], [item2, item2price]]}
    Map totals = Map<String, dynamic>();
    for (var i in rawRes) {
      if (!items.containsKey(i[1])) {
        items[i[1]] = [
          [i[2], i[0]]
        ];
        totals[i[1]] = i[0].toDouble();
      } else {
        var found = false;
        for (var j in items[i[1]]) {
          if (found == false && j[0] == i[2]) {
            found = true;
          }
        }
        if (!found) {
          items[i[1]].add([i[2], i[0]]);
          totals[i[1]] += i[0].toDouble();
        }
      }
    }
    String chosenStore = "";
    var lowestTotal = 0.0;
    int itemsFound = 0;
    items.forEach((key, value) {
      var total = 0.0;
      value.forEach((element) => {total += element[1]});
      if (lowestTotal == 0) {
        // First item is always grabbed (greedy method)
        chosenStore = key;
        lowestTotal = total;
        itemsFound = value.length;
      } else if (value.length >= itemsFound) {
        // Replace only if the number of items is the same as the current count.
        chosenStore = key;
        lowestTotal = total;
        itemsFound = value.length;
      } else if (total < lowestTotal) {
        // Replace if total is lower and we are within 2 items of the current qty.
        chosenStore = key;
        lowestTotal = total;
        itemsFound = value.length;
      }
    });
    // Format as necessary for shopping_trip_results.
    var chosen = Map<String, dynamic>.fromIterable(items[chosenStore],
        key: (item) => chosenStore, value: (item) => item);
    results = chosen;
    update();
  }
}
