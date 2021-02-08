import 'package:flutter/material.dart';
import '../utils/entities/shoppinglist.dart';

class ListTiles extends StatefulWidget {
  const ListTiles({Key key, @required this.shoppinglists}) : super(key: key);
  final List<sList> shoppinglists;

  @override
  _ListTilesState createState() => _ListTilesState();
}

class _ListTilesState extends State<ListTiles> {
  var listToSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (listToSend == null) {
      return _buildShoppingListTiles();
    } else {
      return Center(child: Text(listToSend));
    }
  }

  Widget _buildShoppingListTiles() {
    if (widget.shoppinglists != null) {
      return GridView.extent(
          maxCrossAxisExtent: 150,
          padding: const EdgeInsets.all(18),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: shoppingListTiles(
              widget.shoppinglists.length, widget.shoppinglists));
    } else {
      return GridView.extent(
          maxCrossAxisExtent: 150,
          padding: const EdgeInsets.all(18),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: shoppingListTiles(0, widget.shoppinglists));
    }
  }

  List<Container> shoppingListTiles(int count, List<sList> shoppinglists) {
    List<Container> tilesList, tilesList2;

    tilesList = [addNewListTile()];
    tilesList2 = existingShoppingLists(count, shoppinglists);
    tilesList = tilesList + tilesList2;

    return tilesList;
  }

  Container addNewListTile() {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 10, color: Colors.blueAccent),
            borderRadius: const BorderRadius.all(const Radius.circular(8))),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  listToSend = "create new list";
                });
              }),
          FittedBox(fit: BoxFit.fitWidth, child: Text("Create New List"))
        ]));
  }

  List<Container> existingShoppingLists(int count, List<sList> shoppinglists) =>
      List.generate(
          count,
          (i) => Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 10, color: Colors.blueAccent),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(8))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          setState(() {
                            listToSend = shoppinglists[i].getListName();
                          });
                        }),
                    FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(shoppinglists[i].getListName()))
                  ])));
}
