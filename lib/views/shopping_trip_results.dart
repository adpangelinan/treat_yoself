import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'views.dart';
import 'package:get/get.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

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
  final ShoppingListController slController = Get.find();
  final currency = new NumberFormat("#,##0.00", "en_US");
  @override
  Widget build(BuildContext context) {
    final String tripType = ModalRoute.of(context).settings.arguments;
    return GetBuilder<ShoppingTripController>(
        init: ShoppingTripController(tripType),
        builder: (controller) => controller?.results == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: TopNavBar(title: "Home"),
                drawer: SideDrawer(),
                body: tripType == "singleStore"
                    ? singleStoreBody(controller.results)
                    : bestPriceBody(controller.results),
                bottomNavigationBar: BotNavBar(),
              ));
  }

  Widget singleStoreBody(Map<String, dynamic> res) {
    var storeName = res.keys.toList()[0];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Your Store: ${storeName}",
              style: TextStyle(
                fontSize: 24.00,
              )),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
              itemCount: res.length,
              padding: EdgeInsets.all(16.0),
              itemBuilder: (context, i) {
                return _returnTiles(res[res.keys.toList()[i]]);
              }),
        ),
        res[res.keys.toList()[0]].length < slController.currentList.items.length
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                      "Unfortunately, we couldn't find all items from your cart at a single store.",
                      style: TextStyle(
                        fontSize: 18.00,
                        color: Colors.red,
                      )),
                ),
              )
            : Text("")
      ],
    );
  }

  Widget bestPriceBody(Map<String, dynamic> res) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
                itemCount: res.length,
                padding: EdgeInsets.all(16.0),
                itemBuilder: (context, i) {
                  return _returnTiles(res[res.keys.toList()[i]]);
                }),
          ),
        ),
        res[res.keys.toList()[0]].length < slController.currentList.items.length
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                      "Some of your items couldn't be found anywhere nearby!",
                      style: TextStyle(
                        fontSize: 18.00,
                        color: Colors.red,
                      )),
                ),
              )
            : SizedBox()
      ],
    );
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
                      text: TextSpan(text: '\$${currency.format(result[1])}'),
                    ),
                  ),
                  Flexible(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      strutStyle: StrutStyle(fontSize: 12.0),
                      text: TextSpan(text: '${result[0]}'),
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
