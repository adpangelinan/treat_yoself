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
  Map<String, dynamic> results;
  List<dynamic> rawResults;
  final String lowestPriceQuery =
      "select min(p.Price) as price, s.Name as store, i.Name as item, i.ItemID as itemID from Prices p left join StoresItems si on si.StoreItemID = p.StoreItemID left join BrandsItems bi on si.BrandItemID = bi.BrandItemID left join Items i on i.ItemID = bi.ItemID left join Stores s on s.StoreID = si.StoreID where bi.BrandItemID in (select ItemID from ListItems where ListID = ?) and s.ZipCode = ? group by i.itemID order by price asc ";
  final String singleStoreQuery =
      "select p.Price as price, s.Name as store, i.Name as item, i.ItemID as itemID from Prices p left join StoresItems si on si.StoreItemID = p.StoreItemID left join BrandsItems bi on si.BrandItemID = bi.BrandItemID left join Items i on i.ItemID = bi.ItemID left join Stores s on s.StoreID = si.StoreID where bi.BrandItemID in (select ItemID from ListItems where ListID = ?) and s.ZipCode = ? order by price asc ;";

  @override
  void onReady() {
    super.onReady();
    _getData();
  }

  void _getData() async {
    list = slController.currentList;
    listID = list.listID;
    userZip = authController.firestoreUser.value.zipcode;
    rawResults = await dbConn.manualQuery(lowestPriceQuery, [listID, userZip]);
    setState() {}
    _tripAlgorithm(rawResults);
  }

  void _tripAlgorithm(rawRes) async {
    Map<String, dynamic> bestPrices;
  }
}
