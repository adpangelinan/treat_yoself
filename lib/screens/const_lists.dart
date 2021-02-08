import 'package:flutter/material.dart';
import 'dart:math';


const _categories_list = ["Dairy & Eggs","Meat","Pantry","Fruits & Vegetables","Frozen","Bakery","Seafood", "Beverages", "Deli"];

const _myListOfRandomColors = [
  Colors.red,
  Colors.blue,
  Colors.teal,
  Colors.yellow,
  Colors.amber,
  Colors.deepOrange,
  Colors.green,
  Colors.indigo,
  Colors.lime,
  Colors.pink,
  Colors.orange,
];

final _categoryQueries = [
  'Select Items.Name as Item, Items.Price, Brands.Name as Brand FROM Items JOIN Categories ON Categories.CategoryID = Items.CategoryID JOIN Brands ON Items.BrandID = Brands.BrandID WHERE Categories.Name = ?;',
  'Select Items.Name as Item, Items.Price, Brands.Name as Brand FROM Items JOIN Categories ON Categories.CategoryID = Items.CategoryID JOIN Brands ON Items.BrandID = Brands.BrandID WHERE Categories.Name = ?;',
  'Select Items.Name as Item, Items.Price, Brands.Name as Brand FROM Items JOIN Categories ON Categories.CategoryID = Items.CategoryID JOIN Brands ON Items.BrandID = Brands.BrandID WHERE Categories.Name = ?;',
  'Select Items.Name as Item, Items.Price, Brands.Name as Brand FROM Items JOIN Categories ON Categories.CategoryID = Items.CategoryID JOIN Brands ON Items.BrandID = Brands.BrandID WHERE Categories.Name = ?;',
  'Select Items.Name as Item, Items.Price, Brands.Name as Brand FROM Items JOIN Categories ON Categories.CategoryID = Items.CategoryID JOIN Brands ON Items.BrandID = Brands.BrandID WHERE Categories.Name = ?;',
  'Select Items.Name as Item, Items.Price, Brands.Name as Brand FROM Items JOIN Categories ON Categories.CategoryID = Items.CategoryID JOIN Brands ON Items.BrandID = Brands.BrandID WHERE Categories.Name = ?;',
  'Select Items.Name as Item, Items.Price, Brands.Name as Brand FROM Items JOIN Categories ON Categories.CategoryID = Items.CategoryID JOIN Brands ON Items.BrandID = Brands.BrandID WHERE Categories.Name = ?;',
  'Select Items.Name as Item, Items.Price, Brands.Name as Brand FROM Items JOIN Categories ON Categories.CategoryID = Items.CategoryID JOIN Brands ON Items.BrandID = Brands.BrandID WHERE Categories.Name = ?;',
  'Select Items.Name as Item, Items.Price, Brands.Name as Brand FROM Items JOIN Categories ON Categories.CategoryID = Items.CategoryID JOIN Brands ON Items.BrandID = Brands.BrandID WHERE Categories.Name = ?;',
  'Select Items.Name as Item, Items.Price, Brands.Name as Brand FROM Items JOIN Categories ON Categories.CategoryID = Items.CategoryID JOIN Brands ON Items.BrandID = Brands.BrandID WHERE Categories.Name = ?;',
];

final _random = Random();

MaterialColor getRandomColors() {
    return _myListOfRandomColors[_random.nextInt(_myListOfRandomColors.length)];
}

List<String> getQueries(){
  return _categoryQueries;
}
