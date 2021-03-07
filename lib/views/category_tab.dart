import 'package:flutter/material.dart';
import 'package:treat_yoself/routes.dart';
import 'views.dart';
import 'const_lists.dart';
import 'package:flutter/cupertino.dart';
import './search_results_tab.dart';
import 'components/components.dart';
import './components/bot_nav_bar.dart';
import './components/top_nav_bar.dart';
import 'package:get/get.dart';

class Category extends StatefulWidget {
  const Category({Key key, this.user}) : super(key: key);
  final int user; //#TODO - make User Class
  static String routeName = '/category';
  State<StatefulWidget> createState() => _Categories();
}

class _Categories extends State<Category> {
  List<dynamic> categories = [];
  final dbConn = DatabaseEngine();
  var query = "SELECT Name from Categories;";
  _Categories() {
    dbConn.manualQuery(query).then((res) => setState(() {
          categories = res;
        }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: _buildGrid(),
    );
  }

  Widget _buildGrid() {
    var query =
        'Select Items.Name as Item, BrandsItems.BrandItemID as ID, Brands.Name as Brand FROM Items JOIN Categories ON Categories.CategoryID = Items.CategoryID JOIN BrandsItems ON BrandsItems.ItemID = Items.ItemID JOIN Brands ON Brands.BrandID = BrandsItems.BrandID WHERE Categories.Name = ?;';
    return GridView.count(
        primary: false,
        crossAxisCount: 2,
        padding: const EdgeInsets.all(6),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: categories.map((value) {
          return GestureDetector(
            onTap: () {
              Get.to(Results(query: query, args: value['Name']));
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                    child:
                        Text(value['Name'], style: TextStyle(fontSize: 24)))),
          );
        }).toList());
  }
}
