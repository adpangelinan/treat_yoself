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
          actions: [IconButton(icon: Icon(Icons.shopping_cart), onPressed:  null)]),
        drawer: _returnDrawer()
    ,
      body: List()._buildLists(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white ,
        child: IconButton(icon: Icon(Icons.home), onPressed: _pushRoute)),
        
    );
  }

  void _pushRoute(){
    Navigator.pushReplacementNamed(context, '/landing_page');
    
  }
Widget _returnDrawer(){
  return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Icon(
                Icons.account_circle,
                color: Colors.green.shade800,
                size: 96,
              ),
            ),
          ),
          ListTile(
            //leading: SongsTab.androidIcon,
            title: Text('Profile'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            //leading: NewsTab.androidIcon,
            title: Text('Shopping List'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            //leading: ProfileTab.androidIcon,
            title: Text('Find Items'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          // Long drawer contents are often segmented.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            
          ),
          ListTile(
            //leading: SettingsTab.androidIcon,
            title: Text("Settings"),
            onTap: () {
               Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
  );

  }
  }

class List extends StatelessWidget {
@override
Widget build(BuildContext context){
  return Scaffold(
    body: _buildLists(),);

}


_buildLists(){
  return ListTile(
    title: Text("Add Shopping List"),
      trailing: Icon(
        Icons.add,
        color: Colors.blue,
      ),
  );


}

}

