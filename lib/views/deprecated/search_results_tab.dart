/*
import 'package:flutter/material.dart';
//import 'package:mysql1/mysql1.dart';
//import 'package:mysql1/mysql1.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';
import 'components/components.dart';
import 'const_lists.dart';
import 'package:flutter/cupertino.dart';

import 'dart:convert';

class Results extends StatefulWidget {
  //const Results({Key key, @required this.user}) : super(key: key);
  final int user;
  static String routeName = '/results';
  final String query;
  final String args;
  const Results({Key key, this.query, this.args, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Results();
}

class _Results extends State<Results> {
  //final String query = widget.query;

  void _pushRoute() {
    Navigator.pushReplacementNamed(context, '/landing_page');
  }
/*
  final items = List<ItemDetails>.generate(15, (i) {
    return ItemDetails(
      "name: $i",
      "price:$i",
      "brand:$i",
    );
  });*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Top_Nav_Bar(user: widget.user),
        drawer: SideDrawer(user: widget.user),
        body: printing(),
        bottomNavigationBar: Bot_Nav_Bar(user: widget.user));
  }

  Future<List<ItemDetails>> _buildItems(query) async {
    List<String> temp;
    var database = DatabaseEngine();
    var newstring = await database.manualQuery(widget.query, [widget.args]);
    List<ItemDetails> list = [];
    newstring.forEach((element) {
      temp = element.split(" ");
      var first;
      var two;
      var mid;
      var last;
      var id;
      for (var i = 0; i < temp.length; i++) {
        if (temp[i] == "{Item:") {
          first = temp[i + 1];
          first = first.replaceAll(RegExp(r'[^\w\s]+'), '');
          if (temp[i + 2] != "Price:") {
            two = temp[i + 2];
            two = two.replaceAll(RegExp(r'[^\w\s]+'), '');
            first = first + " " + two;
          }
        } else if (temp[i] == "Price:") {
          mid = temp[i + 1];
          mid = mid.replaceAll(RegExp(r'[^\w\s]+'), '');
        } else if (temp[i] == "ID:") {
          id = temp[i + 1];
          id = id.replaceAll(RegExp(r'[^\w\s]+'), '');
        } else if (temp[i] == "Brand:") {
          last = temp[i + 1];
          last = last.replaceAll(RegExp(r'[^\w\s]+'), '');
        } else if (temp[i] == "Price:") {
          mid = temp[i + 1];
          mid = mid.replaceAll(RegExp(r'[^\w\s]+'), '');
        } else if (temp[i] == "Brand:") {
          last = temp[i + 1];
          last = last.replaceAll(RegExp(r'[^\w\s]+'), '');
        }
      }
      list.add(ItemDetails(first, mid, last, id));
    });
    return list;
  }

  _printItems(items) {
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

  Widget printing() {
    return FutureBuilder<List<ItemDetails>>(
        future: _buildItems(widget.query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ItemDetails> olditems = snapshot.data ?? [];
            return _printItems(olditems);
          } else {
            return Text("Loading Results.....");
          }
        });
  }
}

abstract class ListItem {
  Widget buildItem(BuildContext context);
}

class ItemDetails {
  final String name;
  final String price;
  final String brand;
  final String id;

  ItemDetails(this.name, this.price, this.brand, this.id);

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
        color: getRandomColors(),
        child: InkWell(
          onTap: () => null,
          splashColor: Colors.white,
          child: ListTile(
            title: Text(name),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(brand), Text(price)],
            ),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart_sharp),
              tooltip: 'Add Item',
              onPressed: () => _popUp(context, id),
            ),
            tileColor: getRandomColors(),
          ),
        ),
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ));
}
*/
