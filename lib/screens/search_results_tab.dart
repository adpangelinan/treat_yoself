import 'package:flutter/material.dart';
import '../components/drawer.dart';
import 'package:treat_yoself/routes.dart';
import 'const_lists.dart';
import 'package:flutter/cupertino.dart';

class Results extends StatefulWidget {
  const Results({Key key, @required this.user}) : super(key: key);
  final int user;
  static String routeName = '/results';
  State<StatefulWidget> createState() => _Results();
}

class _Results extends State<Results> {
  void _pushRoute() {
    Navigator.pushReplacementNamed(context, '/landing_page');
  }

  final items = List<ItemDetails>.generate(15, (i) {
    return ItemDetails(
      "name: $i",
      "price:$i",
      "brand:$i",
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Results'), actions: [
        IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/shoppinglist');
            }),
        IconButton(
            icon: Icon(Icons.camera_alt_outlined),
            onPressed: () {
              //TODO: Camera page and route
            }),
      ]),
      drawer: SideDrawer(user: widget.user),
      body: _buildItems(),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: IconButton(icon: Icon(Icons.home), onPressed: _pushRoute)),
    );
  }

  _buildItems() {
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

abstract class ListItem {
  Widget buildItem(BuildContext context);
}

class ItemDetails {
  final String name;
  final String price;
  final String brand;

  ItemDetails(this.name, this.price, this.brand);
  _popUp(context) {
    //add insert query

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
              onPressed: () => _popUp(context),
            ),
            tileColor: getRandomColors(),
          ),
        ),
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ));
}
