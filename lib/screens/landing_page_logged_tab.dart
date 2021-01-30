import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:treat_yoself/utils/database/sql_controller.dart';
import 'login_tab.dart';
import 'list_tiles.dart';
import 'feed.dart';
import '../widgets/drawer.dart';

/*Class Landing Paged Logged
Landing Page for a user that is currently logged in
 */
class LandingPageLogged extends StatefulWidget {
  @override
  _LandingPageLogged createState() => _LandingPageLogged();
  static String routeName = '/landing_page';
}

class _LandingPageLogged extends State<LandingPageLogged> {
  void _pushRoute() {
    Navigator.pushReplacementNamed(context, '/landing_page');
  }

  Widget build(BuildContext context) {
    //build a news feed list
    return Scaffold(
      appBar: AppBar(title: Text('Home'), actions: [
        IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/shopping_list');
            }),
        IconButton(
            icon: Icon(Icons.camera_alt_outlined),
            onPressed: () {
              //TODO: Camera page and route
            }),
      ]),
      drawer: SideDrawer(),
      body: _buildBody(),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: IconButton(icon: Icon(Icons.home), onPressed: _pushRoute)),
    );
  }

  void _pushRouteOptions() {
    Navigator.pushReplacementNamed(context, '/option');
  }
}

Widget _buildBody() {
  return Container(
      child: Column(children: [
    Expanded(
        child: Row(children: [
      Container(width: 360, color: Colors.red, child: Feed())
    ])),
    Expanded(child: Row(children: [Container(width: 360, child: ListTiles())])),
  ]));
}
