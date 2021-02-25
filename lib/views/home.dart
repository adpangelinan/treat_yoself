import 'package:flutter/material.dart';
import 'package:treat_yoself/constants/app_routes.dart';
import 'package:treat_yoself/localizations/localizations.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'views.dart';
import 'package:get/get.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';
import 'auth/auth.dart';
import 'package:date_format/date_format.dart';
import 'dart:math';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  List<dynamic> results;
  final dbConn = DatabaseEngine();
  final queryString = "SELECT * FROM Comments ORDER BY DateAdded LIMIT ?";
  //final LocationController location = Get.put(LocationController());

  _HomeUIState() {
    dbConn.manualQuery(queryString, [30]).then((res) => setState(() {
          results = res;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller?.firestoreUser?.value?.uid == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: TopNavBar(
                title: "Home",
              ),
              drawer: SideDrawer(),
              body: homepageBody(context, results),
              bottomNavigationBar: BotNavBar(),
            ),
    );
  }

  Widget homepageBody(BuildContext context, List<dynamic> results) {
    return Container(
        child: Column(children: [
      Expanded(child: _buildTiles(results)),
      //Expanded(child: Container(width: 360, child: MyCustomForm(user)))
    ]));
  }

  Widget _buildTiles(var results) {
    return ListView.builder(
        itemCount: results.length,
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return _returnTiles(results[i]);
        });
  }

  Widget _returnTiles(var result) {
    final leftSection = new Container(
      child: new CircleAvatar(
        backgroundImage: new NetworkImage('https://picsum.photos/200/200'),
        backgroundColor: Colors.lightGreen,
        radius: 24.0,
      ),
    );
    final middleTile = new Expanded(
        child: Container(
            padding: EdgeInsets.only(left: 8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Text(
                    "${convertDateFromString(result[2].toString(), 'date')}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
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
            "${convertDateFromString(result[2].toString(), 'time')}",
            style: new TextStyle(color: Colors.lightGreen, fontSize: 12.0),
          ),
          new CircleAvatar(
            backgroundColor: Colors.lightGreen,
            radius: 10.0,
            child: new Text(
              "2",
              style: new TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          )
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
        children: <Widget>[leftSection, middleTile, rightSection],
      ),
    );
  }

  String convertDateFromString(String strDate, String dateOrTime) {
    DateTime todayDate = DateTime.parse(strDate);
    if (dateOrTime == 'date') {
      return formatDate(todayDate, [yyyy, '/', mm, '/', dd]);
    } else {
      return formatDate(todayDate, [h, ':', mm, ' ', am]);
    }
  }
}