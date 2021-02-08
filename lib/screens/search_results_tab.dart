import 'package:flutter/material.dart';
//import 'package:mysql1/mysql1.dart';
//import 'package:mysql1/mysql1.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';
import '../components/drawer.dart';
import 'const_lists.dart';
import 'package:flutter/cupertino.dart';
import '../components/top_nav_bar.dart';
import '../components/bot_nav_bar.dart';
import 'dart:convert';


class Results extends StatefulWidget {
  static String routeName = '/results';
  final String query;
  final String args; 
  const Results ({Key key, this.query, this.args}): super(key: key);
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
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: Top_Nav_Bar(),
      drawer: SideDrawer(),
      body: printing(),
      bottomNavigationBar: Bot_Nav_Bar());
  }

  Future<List<ItemDetails>> _buildItems(query) async {
      print('testing');
      List<String> temp; 
      var database = DatabaseEngine(); 
      var newstring =  await  database.manualQuery(widget.query,[widget.args]);
      print(newstring);
      var parsed =  newstring.toString();
      List<ItemDetails> list = [];
      newstring.forEach((element) {
        temp = element.split(" ");
        print(temp);
        var first;
        var two; 
        var mid; 
        var last; 
        for(var i=0; i < temp.length; i++){
          if (temp[i] == "{Item:"){
            first = temp[i+1];
            first = first.replaceAll(RegExp(r'[^\w\s]+'), '');
            if(temp[i+2] != "Price:"){
              two = temp[i+2];
              two = two.replaceAll(RegExp(r'[^\w\s]+'), '');
              first = first + " " + two; 
            }
          }
          else if(temp[i] == "Price:"){
            mid = temp[i+1];
            mid = mid.replaceAll(RegExp(r'[^\w\s]+'), ''); 
          }
          else if(temp[i]== "Brand:"){
            last =temp[i+1]; 
            last = last.replaceAll(RegExp(r'[^\w\s]+'), '');
          }
        }
        list.add(ItemDetails(first,mid,last));
      
      });
      return list;

  }
  _printItems(items){
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

  Widget printing(){

    return FutureBuilder<List<ItemDetails>>(future: _buildItems(widget.query), builder: (context, snapshot){
      if(snapshot.hasData){
        List<ItemDetails> olditems = snapshot.data ?? []; 
        return _printItems(olditems);
      }
      else{
        return Text("Loading Results.....");
      }
    })
  ;
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
