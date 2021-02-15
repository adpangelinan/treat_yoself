import 'package:flutter/material.dart';
import 'package:treat_yoself/constants/app_routes.dart';
import 'package:treat_yoself/localizations/localizations.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'package:treat_yoself/screens/category_tab.dart';
import 'package:treat_yoself/screens/components/components.dart';
import 'package:treat_yoself/screens/screens.dart';
import 'package:get/get.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';
import 'auth/auth.dart';
import 'package:date_format/date_format.dart';
import 'dart:math';



class ItemLocation extends StatefulWidget{
  @override
  _ItemLocation createState() => _ItemLocation();

}

class _ItemLocation extends State<ItemLocation>{
List<dynamic> stuff; 
final LocationController controller = Get.put(LocationController());

@override build(BuildContext context) {
     return  Scaffold(
              appBar: TopNavBar(title: "Best Prices",),
              drawer: SideDrawer(),
              body:  printing(),
              bottomNavigationBar: Bot_Nav_Bar(),
            );



}

  Widget printing() {
    return FutureBuilder<String>(
        future: getzip(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String olditems = snapshot.data ?? [];
            return generateLocation(olditems);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }


Widget generateLocation(y) {


return Text(y);

}

Future<String>getzip() async{

var results = await controller.tranlateToZip();

return results; 
}
}