import 'package:flutter/material.dart';
import 'package:treat_yoself/constants/app_routes.dart';
import 'package:treat_yoself/localizations/localizations.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'views.dart';
import 'package:get/get.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';
import 'auth/auth.dart';
import 'package:date_format/date_format.dart';
import 'dart:math';

class ItemLocation extends StatefulWidget {
  final name;
  @override
  _ItemLocation createState() => _ItemLocation();
  const ItemLocation({this.name});
}

class _ItemLocation extends State<ItemLocation> {
  List<dynamic> stuff;
  final LocationController controller = Get.put(LocationController());

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Best Prices"),
      ),
      body: buildZip(),
      bottomNavigationBar: BotNavBar(),
    );
  }

  Widget buildZip() {
    return FutureBuilder<String>(
        future: getzip(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String olditems = snapshot.data ?? [];
            return generateLocation(olditems);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget generateLocation(zip) {
    return FutureBuilder<List<ItemLocationTile>>(
        future: zipQuery(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ItemLocationTile> items = snapshot.data ?? [];
            return buildTiles(items);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget buildTiles(items) {
    if (items.length == 0) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "No Nearby Prices Found",
          style: TextStyle(fontSize: 30.00),
        ),
      ));
    } else {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            child: item.buildItem(context),
          );
        },
      );
    }
  }

  Future<List<ItemLocationTile>> zipQuery() async {
    var database = DatabaseEngine();
    var args = [
      widget.name,
      "12345",
    ];
    var query =
        "Select Distinct Stores.Name as Item, Stores.ZipCode as ID, ListItems.ListItemID as ListID, Brands.Name as Brand FROM Items JOIN BrandsItems On BrandsItems.ItemID = Items.ItemID JOIN Brands ON Brands.BrandID = BrandsItems.BrandID JOIN ListItems ON BrandsItems.BrandItemID = ListItems.ItemID JOIN StoresItems ON BrandsItems.BrandItemID = StoresItems.BrandItemID JOIN Stores ON Stores.StoreID = StoresItems.StoreID WHERE BrandsItems.BrandItemID = ? AND Stores.ZipCode = ?;";
    var newstring = await database.manualQuery(query, args);
    List<ItemLocationTile> list = [];
    newstring.forEach((element) {
      var first = element.values[0];
      var mid = element.values[1].toString();
      var last = element.values[3];
      var id = element.values[2].toString();
      list.add(ItemLocationTile(first, mid, last, id));
    });
    return list;
  }

  Future<String> getzip() async {
    var results = await controller.tranlateToZip();

    return results;
  }
}

class ItemLocationTile {
  final String name;
  final String price;
  final String brand;
  final String id;

  ItemLocationTile(this.name, this.price, this.brand, this.id);

  insertData(id) async {
    var listID = "42"; //add user data class to extract this id from it
    var database = DatabaseEngine();
    var insertquery = "Insert Into ListItems VALUES(NULL,?,?,1)";
    var data;
    data = await database.manualQuery(insertquery, [listID, id]);
    print(data);
    return data;
  }

  _popUp(context, id) async {
    //add insert query
    await insertData(id);

    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Item Added To Cart"),
              actions: [
                TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            ));
  }

  Widget buildItem(BuildContext context) => Card(
          child: Material(
        child: InkWell(
          onTap: () => null,
          splashColor: Colors.white,
          child: ListTile(
            title: Text(name),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(brand), Text(price)],
            ),
            ),
          ),
        ),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      );
}
