import 'package:flutter/material.dart';
import '../components/drawer.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';
import '../components/drawer.dart';
import 'const_lists.dart';
import 'package:flutter/cupertino.dart';
import '../components/top_nav_bar.dart';
import '../components/bot_nav_bar.dart';

class ShoppingTripGen extends StatefulWidget {
  final int user;
  static String routeName = '/current_list';
  final String args; 
  const ShoppingTripGen ({Key key, this.args,this.user}): super(key: key);
  @override
  State<StatefulWidget> createState() => _CurrentItems();
}

class _CurrentItems extends State<ShoppingTripGen>{

  @override
  Widget build(BuildContext context)  { 
    return Scaffold(
      appBar: Top_Nav_Bar(user:widget.user,title: "Shopping Cart"),
      drawer: SideDrawer(user:widget.user),
      body: printing(),
      bottomNavigationBar: Bot_Nav_Bar(user:widget.user));
}


  Widget printing(){

    return FutureBuilder<List<ShoppingItem>>(future: _buildItems(), builder: (context, snapshot){
      if(snapshot.hasData){
        List<ShoppingItem> olditems = snapshot.data ?? []; 
        return _printItems(olditems);
      }
      else{
        return Text("Loading Results.....");
      }
    })
  ;
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

  Future<List<ShoppingItem>> _buildItems() async {
      List<String> temp; 
      var dataquery = "Select Items.Name as Item, Items.Price as Price, Items.ItemID as ID, ListItems.ListItemID as ListID, Brands.Name as Brand FROM Items JOIN Brands On Brands.BrandID = Items.BrandID JOIN ListItems ON Items.ItemID = ListItems.ItemID WHERE ListItems.ListID = ?;";
      var listID = "42";
      var database = DatabaseEngine(); 
      var newstring =  await  database.manualQuery(dataquery,[listID]);
      List<ShoppingItem> list = [];
      newstring.forEach((element) {
        temp = element.split(" ");
        var first;
        var two; 
        var mid; 
        var last; 
        var id; 
        var listID; 
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
          else if(temp[i] == "ID:"){
            id = temp[i+1];
            id = id.replaceAll(RegExp(r'[^\w\s]+'), '');
          }
          else if(temp[i]== "Brand:"){
            last =temp[i+1]; 
            last = last.replaceAll(RegExp(r'[^\w\s]+'), '');
          }
          else if(temp[i] == "ListID:"){
            listID = temp[i+1];
            listID = listID.replaceAll(RegExp(r'[^\w\s]+'), '');
          }
        }
        list.add(ShoppingItem(first,mid,last,id,listID));
      
      });
      return list;

  }




}


class ShoppingItem{
  final String name;
  final String price;
  final String brand;
  final String id; 
  final String listID; 

  ShoppingItem(this.name, this.price, this.brand,this.id,this.listID);

  delete(deleting) async{
     //add user data class to extract this id from it
    var database = DatabaseEngine();
    var insertquery = "Delete FROM ListItems WHERE ListItemID = ?"; 
    var  data; 
    data =  await  database.manualQuery(insertquery,[deleting]);
    return data;

  }

  void setState(){
    
  }
  _deleteItem(context,id) async {
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
                      Navigator.of(context).pushNamed('/current_list',);
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
              icon: Icon(Icons.delete),
              tooltip: 'Delete Item',
              onPressed: () => _deleteItem(context,listID),
            ),
            tileColor: getRandomColors(),
          ),
        ),
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ));


}