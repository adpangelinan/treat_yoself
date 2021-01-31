import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import 'const_lists.dart';
import 'package:flutter/cupertino.dart';



class Results extends StatefulWidget {
  static String routeName = '/results';
  State<StatefulWidget> createState() => _Results();
}

class _Results extends State<Results> {
  void _pushRoute() {
    Navigator.pushReplacementNamed(context, '/landing_page');}

  final items = List<ItemDetails>.generate(15, (i) {return ItemDetails("name: $i", "price:$i", "brand:$i",);
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
      drawer: SideDrawer(),
      body: _buildItems(),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: IconButton(icon: Icon(Icons.home), onPressed: _pushRoute)),
    );
  }



  _buildItems(){
    return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context,index){
    final item = items[index];
    return Container(child: item.buildItem(context),);
    },);
    }
  

}

abstract class ListItem{

  Widget buildItem(BuildContext context);

}




  class ItemDetails {
    final String name;
    final String price;
    final String brand; 

    ItemDetails(this.name,this.price,this.brand); 

    Widget buildItem(BuildContext context) => Card(
      child: Material(
        color: getRandomColors(),
          child: InkWell(
            onTap: () =>
                    Navigator.pushReplacementNamed(context, '/shopping_list'),
            splashColor: Colors.white,
              child: ListTile(
              title: Text(name), 
              subtitle: Text(price), 
              trailing: Text(brand), 
              tileColor: getRandomColors(),),
          ),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
     )
    );
  }
