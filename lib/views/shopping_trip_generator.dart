import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'views.dart';
import 'package:get/get.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';
import 'package:date_format/date_format.dart';

class ShoppingTripGen extends StatefulWidget {
  var commentBox = true;
  @override
  _ShoppingTripGenState createState() => _ShoppingTripGenState();
}

class _ShoppingTripGenState extends State<ShoppingTripGen> {
  List<dynamic> results;
  List<dynamic> priceResults;
  final dbConn = DatabaseEngine();
  final RewardsController rewardsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShoppingTripController>(
        init: ShoppingTripController(),
        builder: (controller) => controller?.rawResults == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: TopNavBar(title: "Home"),
                drawer: SideDrawer(),
                body: shoppingTripBody(controller.rawResults),
                bottomNavigationBar: BotNavBar(),
              ));
  }

  Widget shoppingTripBody(res) {
    return ListView.builder(
        itemCount: res.length,
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return _returnTiles(res[i]);
        });
  }

  Widget _returnTiles(var result) {
    final middleTile = new Expanded(
        child: Container(
            padding: EdgeInsets.only(left: 8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      strutStyle: StrutStyle(fontSize: 12.0),
                      text: TextSpan(text: '${result[2]}'),
                    ),
                  ),
                  Flexible(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      strutStyle: StrutStyle(fontSize: 12.0),
                      text: TextSpan(text: '${result[1]}'),
                    ),
                  ),
                ])));

    final rightSection = new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Text(
            "${result[0]}",
            style: new TextStyle(color: Colors.lightGreen, fontSize: 12.0),
          ),
        ],
      ),
    );

    return new Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      padding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      height: 70.0,
      child: new Row(
        children: <Widget>[middleTile, rightSection],
      ),
    );
  }
}
