import 'package:flutter/material.dart';
import '../widgets/drawer.dart';

class Category extends StatefulWidget {
  static String routeName = '/category';
  State<StatefulWidget> createState() => _Categories();
}

class _Categories extends State<Category>{
   void _pushRoute() {
    Navigator.pushReplacementNamed(context, '/landing_page');
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: Text('Treat Yo Self'), actions: [
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
      body: _buildGrid(),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: IconButton(icon: Icon(Icons.home), onPressed: _pushRoute)),
    );
  }

  Widget _buildGrid() => GridView.extent(
    maxCrossAxisExtent: 150,
    padding: const EdgeInsets.all(4),
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: _buildGridTileList(12));

// The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
// The List.generate() constructor allows an easy way to create
// a list when objects have a predictable naming pattern.
List<Container> _buildGridTileList(int count) => List.generate(
    count, (i) => Container(
      child: GridTile(
        child: CircleAvatar( 
          backgroundImage: NetworkImage('https://picsum.photos/250?image=9')
        ) ,
      )
    )
  );

}


 
