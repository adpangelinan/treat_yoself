 import 'package:flutter/material.dart';

 class StarRating extends StatelessWidget {
  final int starCount;
  final int rating;
  final Color color;
// Sources Cited: https://stackoverflow.com/questions/46637566/how-to-create-rating-star-bar-properly
  StarRating({this.starCount = 5, this.rating = 0, this.color});
 Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border, //build outlined star
        color: Theme.of(context).buttonColor,
        size:15,
      );
    }
    else {
      icon = new Icon(
        Icons.star,  //build solid star
        color: color ?? Theme.of(context).primaryColor,
        size: 15,
      );
    }
    return new InkResponse(
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: new List.generate(starCount, (index) => buildStar(context, index))); //build a certain number of starts
  }
}