import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';
import 'package:treat_yoself/screens/screens.dart';
import './item_location_services.dart';
import 'const_lists.dart';
import 'package:flutter/cupertino.dart';
import 'components/components.dart';
import '../utils/entities/shoppinglist.dart';
import '../utils/entities/shoppingitem.dart';

class ShoppingTripGen extends StatefulWidget {
  final int user;
  static String routeName = '/current_list';
  final String args;
  const ShoppingTripGen({Key key, this.args, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CurrentItems();
}

class _CurrentItems extends State<ShoppingTripGen> {
  final shoppingListController = Get.put(ShoppingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopNavBar(title: "Shopping Cart"),
        drawer: SideDrawer(),
        body: _printItems(),
        bottomNavigationBar: Bot_Nav_Bar());
  }

/*
  Widget printing() {
    return FutureBuilder<List<ShoppingItem>>(
        future: _buildItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ShoppingItem> olditems = snapshot.data ?? [];
            return _printItems();
          } else {
            return Text("Loading Results.....");
          }
        });
  }
*/
  Widget _printItems() {
    List<ShoppingItem> mylist = _buildItems();
    print("Here, list is $mylist");
    print(shoppingListController.currentList.items);
    return ListView.builder(
      itemCount: mylist.length,
      itemBuilder: (context, index) {
        final item = mylist[index];
        return Container(
          child: buildItem(context, item),
        );
      },
    );
  }

  List<ShoppingItem> _buildItems() {
    var list = shoppingListController.currentList.items;

    return list;
  }

  Widget buildItem(BuildContext context, ShoppingItem item) => Card(
        child: Material(
            color: getRandomColors(),
            child: InkWell(
              onTap: () => _pushRoute(),
              splashColor: Colors.white,
              child: ListTile(
                title: Text(item.name),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Brand: ${item.brand}"),
                    Text("Price: ${item.price.toString()}"),
                    Text("Quantity: ${item.quantity.toString()}"),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  tooltip: 'Delete Item',
                  onPressed: () {
                    //_deleteItem(context, listID);
                  },
                ),
                tileColor: getRandomColors(),
              ),
            )),
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      );

  _pushRoute() {
    Get.to(ItemLocation());
  }
}
/*
class ShoppingItem {
  

  delete(deleting) async {
    //add user data class to extract this id from it
    var database = DatabaseEngine();
    var insertquery = "Delete FROM ListItems WHERE ListItemID = ?";
    var data;
    data = await database.manualQuery(insertquery, [deleting]);
    return data;
  }

  void setState() {
    Get.to(ShoppingTripGen());
  }

  _deleteItem(context, id) async {
    await delete(id);

    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Item Deleted"),
              actions: [
                TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      navigator.push(MaterialPageRoute(builder: (_) {
                        return ShoppingTripGen();
                      }));
                    })
              ],
            ));
  }

 
}
*/
