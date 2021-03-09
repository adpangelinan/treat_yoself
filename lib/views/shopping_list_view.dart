import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/shoppinglists_controller.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';
import 'item_location_services.dart';
import 'views.dart';
import 'const_lists.dart';
import 'package:flutter/cupertino.dart';
import 'components/components.dart';

class ShoppingListView extends StatefulWidget {
  final int user;
  static String routeName = '/current_list';
  final String args;
  const ShoppingListView({Key key, this.args, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CurrentItems();
}

class _CurrentItems extends State<ShoppingListView> {
  final ShoppingListController slController = Get.find();
  bool populated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(title: "Shopping Cart"),
      drawer: SideDrawer(),
      body: printing(),
      bottomNavigationBar: BotNavBar(),
      floatingActionButton: addItemButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget printing() {
    return FutureBuilder<List<ShoppingItem>>(
        future: _buildItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String lName = slController.currentList.getListName();
            List<ShoppingItem> olditems = snapshot.data ?? [];
            populated = olditems.length == 0 ? false : true;
            return _printItems(olditems, lName);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  _printItems(items, lName) {
    final _formKey = GlobalKey<FormState>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: StrutStyle(fontSize: 12.0),
              text: TextSpan(text: lName, style: TextStyle(fontSize: 21.0)),
            ),
            RaisedButton(
              color: Colors.green,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("What sort of trip?"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      onPressed: () async {
                                        Get.to(ShoppingTripGen(),
                                            arguments: "singleStore");
                                      },
                                      child: Text("Fewest Stores"),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      onPressed: () async {
                                        Get.to(ShoppingTripGen(),
                                            arguments: "lowestPrice");
                                      },
                                      child: Text("Lowest Price"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Text("Go Shop!"),
            ),
          ],
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: populated
                ? ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Container(
                        child: item.buildItem(context),
                      );
                    },
                  )
                : Center(
                    child: Text(
                    "No Items Added",
                    style: TextStyle(fontSize: 50.00),
                  ))),
      ],
    );
  }

  Future<List<ShoppingItem>> _buildItems() async {
    final ShoppingListController curLis = Get.find();
    var dataquery =
        "Select Items.Name as Item, BrandsItems.BrandItemID as ID, ListItems.ListItemID as ListID, Brands.Name as Brand FROM Items JOIN BrandsItems On BrandsItems.ItemID = Items.ItemID JOIN Brands ON Brands.BrandID = BrandsItems.BrandID JOIN ListItems ON BrandsItems.BrandItemID = ListItems.ItemID WHERE ListItems.ListID = ?;";
    var listID = curLis.currentList.listID;
    var database = DatabaseEngine();
    var newstring = await database.manualQuery(dataquery, [listID]);
    List<ShoppingItem> list = [];
    newstring.forEach((element) {
      var first = element.values[0];
      var last = element.values[3];
      var id = element.values[1].toString();
      var listID = element.values[2].toString();

      list.add(ShoppingItem(first, id, listID, last));
    });
    return list;
  }

  Widget addItemButton() {
    return FloatingActionButton(
        heroTag: "shoppingListBtn",
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(Category());
        });
  }
}

class ShoppingItem {
  final String name;
  final String brand;
  final String id;
  final String listID;

  ShoppingItem(this.name, this.id, this.listID, this.brand);

  delete(deleting) async {
    //add user data class to extract this id from it
    var database = DatabaseEngine();
    var insertquery = "Delete FROM ListItems WHERE ListItemID = ?";
    var data;
    data = await database.manualQuery(insertquery, [deleting]);
    return data;
  }

  void setState() {
    Get.to(ShoppingListView());
  }

  _deleteItem(context, listID) async {
    await delete(listID);

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
                        return ShoppingListView();
                      }));
                    })
              ],
            ));
  }

  Widget buildItem(BuildContext context) => Card(
        child: Material(
            child: InkWell(
          onTap: () => _pushRoute(),
          splashColor: Colors.white,
          child: ListTile(
            title: Text(name),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(brand),
                Text("Tap for prices."),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              tooltip: 'Delete Item',
              onPressed: () => _deleteItem(context, listID),
            ),
          ),
        )),
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      );

  _pushRoute() {
    Get.to(ItemLocation(name: id));
  }
}
