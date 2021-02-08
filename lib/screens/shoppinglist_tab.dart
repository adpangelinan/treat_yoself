import 'dart:convert';

import 'package:flutter/material.dart';
import 'components/components.dart';
import 'package:treat_yoself/screens/search_results_tab.dart';
import './search_results_tab.dart';
import 'const_lists.dart';
import './list_tiles.dart';

import '../utils/database/db_utils.dart';
import 'dart:async';
import '../utils/entities/shoppinglist.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key key, this.user}) : super(key: key);
  static String routeName = '/shopping_list';
  final int user;
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final dbEngine = new DatabaseEngine();

  @override
  Widget build(BuildContext context) {
    //build a news feed list
    return FutureBuilder(
        future: fetchShoppingLists(),
        builder: (BuildContext context, AsyncSnapshot<List<sList>> snapshot) {
          print(snapshot.toString());
          print(snapshot.data.toString());
          if (snapshot.hasData) {
            // If database data received
            return Scaffold(
              appBar: Top_Nav_Bar(user: widget.user),
              drawer: SideDrawer(user: widget.user),
              body: _buildLists(snapshot.data),
              bottomNavigationBar: Bot_Nav_Bar(user: widget.user),
            );
          } else if (snapshot.hasError) {
            //database error
            return Scaffold(
              appBar: Top_Nav_Bar(user: widget.user),
              drawer: SideDrawer(user: widget.user),
              body: Text("Error with database data"),
              bottomNavigationBar: Bot_Nav_Bar(user: widget.user),
            );
          } else {
            return Scaffold(
              appBar: Top_Nav_Bar(user: widget.user),
              drawer: SideDrawer(user: widget.user),
              body: _buildLists(createNullList()),
              bottomNavigationBar: Bot_Nav_Bar(user: widget.user),
            );
          }
        });
  }

  List<sList> createNullList() {
    List<sList> nullList;
    return nullList;
  }

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

  _buildLists(List<sList> shoppinglists) {
    return Container(
        child: Column(children: [
      Expanded(child: ListTiles(shoppinglists: shoppinglists))
    ]));
  }
}

class Items {
  final String name;
  final String price;
  final String brand;

  Items(this.name, this.price, this.brand);

  buildItem() {
    return Card(
        child: Material(
      color: getRandomColors(),
      child: InkWell(
        onTap: () => null,
        splashColor: Colors.white,
        child: ListTile(
          title: Text(name),
          subtitle: Text(price),
          trailing: Text(brand),
          tileColor: getRandomColors(),
        ),
      ),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    ));
  }
}

final topRow = new Expanded(
    child: Container(
        padding: EdgeInsets.only(left: 8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Text(
                "Add New Item",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ])));

_addNewRow() {
  return Row(children: [
    Container(
        padding: EdgeInsets.only(left: 8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Text(
                "Item Added",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ]))
  ]);
}
