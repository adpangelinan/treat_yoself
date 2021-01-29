import 'package:flutter/material.dart';

class ListTiles extends StatefulWidget {
  @override
  _ListTilesState createState() => _ListTilesState();
}

class _ListTilesState extends State<ListTiles> {
  /*Dummy Data*/
  var numLists = 7;
  var listNames = [
    'List 1',
    'Dinner',
    'Adrian',
    'List',
    'List 5',
    'List 6',
    'List 7'
  ];
  var listToSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 2, color: Colors.blueAccent)),
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

  Widget _buildShoppingListTiles() => GridView.extent(
      maxCrossAxisExtent: 90,
      padding: const EdgeInsets.all(18),
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      children: shoppingListTiles(numLists, listNames));

  List<Container> shoppingListTiles(int count, names) {
    List<Container> tilesList, tilesList2;

    tilesList = [addNewListTile()];
    tilesList2 = existingShoppingLists(count, names);
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

  List<Container> existingShoppingLists(int count, names) => List.generate(
      count,
      (i) => Container(
          decoration: BoxDecoration(
              border: Border.all(width: 10, color: Colors.blueAccent),
              borderRadius: const BorderRadius.all(const Radius.circular(8))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      setState(() {
                        listToSend = names[i];
                      });
                    }),
                FittedBox(fit: BoxFit.fitWidth, child: Text(names[i]))
              ])));
}
