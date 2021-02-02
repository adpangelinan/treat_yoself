import 'package:flutter/material.dart';
import '../components/drawer.dart';

class ShoppingList extends StatefulWidget {
  static String routeName = '/shopping_list';
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    //build a news feed list
    return Scaffold(
      appBar: AppBar(title: Text('Treat Yo Self'), actions: [
        IconButton(icon: Icon(Icons.shopping_cart), onPressed: null)
      ]),
      drawer: SideDrawer(),
      body: Lists(),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: IconButton(icon: Icon(Icons.home), onPressed: _pushRoute)),
    );
  }

  void _pushRoute() {
    Navigator.pushReplacementNamed(context, '/landing_page');
  }
}

class Lists extends StatefulWidget {
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<Lists> {
  List<Widget> _itemList = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Row(children: [
          topRow,
          IconButton(icon: Icon(Icons.add), onPressed: _addShoppingList)
        ]),
        Column(children: _itemList),
      ],
    ));
  }

  _addShoppingList() {
    List<Widget> temp = _itemList;
    temp.add(_addNewRow());
    setState(() {
      _itemList = temp;
    });
  }

  _buildLists() {
    return Container(
        child: ListTile(
      title: Text("Create List"),
      trailing: Icon(
        Icons.add,
        color: Colors.blue,
      ),
    ));
  }
}
