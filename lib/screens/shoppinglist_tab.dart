import 'package:flutter/material.dart';


class ShoppingList extends StatefulWidget {
  static String routeName = '/shoppinglist';
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  
  Widget build(BuildContext context){  //build a news feed list 
    return Scaffold(
      appBar: AppBar(
        title: Text('Treat Yo Self'),
         actions: [
           IconButton(icon: Icon(Icons.list), onPressed: _pushRoute), IconButton(icon: Icon(Icons.local_grocery_store), onPressed: null)
         ],
      ),
    );
      //body: _,
  }

  void _pushRoute(){
    Navigator.pushReplacementNamed(context, '/option');
    
  }

  }
