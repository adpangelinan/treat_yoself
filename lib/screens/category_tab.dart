import 'package:flutter/material.dart';
import '../components/drawer.dart';
import 'const_lists.dart';
import 'package:flutter/cupertino.dart';

class Category extends StatefulWidget {
  static String routeName = '/category';
  State<StatefulWidget> createState() => _Categories();
}

class _Categories extends State<Category> {
  void _pushRoute() {
    Navigator.pushReplacementNamed(context, '/landing_page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories'), actions: [
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
          maxCrossAxisExtent: 200,
          padding: const EdgeInsets.all(1),
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          children: [
            CategoryCard(0),
            CategoryCard(1),
            CategoryCard(2),
            CategoryCard(3),
            CategoryCard(4),
            CategoryCard(5),
            CategoryCard(6),
            CategoryCard(7),
            CategoryCard(8),
            CategoryCard(9),
          ]);

// The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
// The List.generate() constructor allows an easy way to create
// a list when objects have a predictable naming pattern.
  List<Container> _buildGridTileList(int count) => List.generate(
      count,
      (i) => Container(
              child: GridTile(
            child: Row(children: [CategoryCard(i)]),
          )));
}

class CategoryCard extends StatelessWidget {
  final _itemsLength = 10;
  final title = 'Categories';
  final androidIcon = Icon(Icons.music_note);
  final iosIcon = Icon(CupertinoIcons.music_note);

  final List<String> categoryNames = [
    "Dairy",
    "Meat",
    "Pantry",
    "Fruits",
    "Vegetables",
    "Frozen",
    "Bakery",
    "Seafood",
    "Beverages",
    "Deli",
  ];
  CategoryCard(this.index);
  final int index;

  @override
  Widget build(BuildContext context) {
    if (index >= _itemsLength) return null;

    // Show a slightly different color palette. Show poppy-ier colors on iOS
    // due to lighter contrasting bars and tone it down on Android.

    return SafeArea(
      top: false,
      bottom: false,
      child: Hero(
        tag: index,
        child: HeroAnimatingSongCard(
          song: categoryNames[index],
          color: getRandomColors(),
          heroAnimation: AlwaysStoppedAnimation(0),
        ),
      ),
    );
  }
}

class HeroAnimatingSongCard extends StatelessWidget {
  HeroAnimatingSongCard(
      {this.song, this.color, this.heroAnimation, this.onPressed});

  final String song;
  final Color color;
  final Animation<double> heroAnimation;
  final VoidCallback onPressed;

  @override
  Widget build(context) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        elevation: 10,
        child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            color: getRandomColors(),
            child: InkWell(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, '/item_search'),
              splashColor: Colors.white,
              child: SizedBox(
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // The song title banner slides off in the hero animation.
                    Text(
                      song,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // The play button grows in the hero animation.
                  ],
                ),
              ),
            )));
  }
}
