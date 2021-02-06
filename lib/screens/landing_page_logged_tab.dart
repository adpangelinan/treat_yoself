import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:treat_yoself/utils/database/sql_controller.dart';
import 'login_tab.dart';
import 'list_tiles.dart';
import 'feed.dart';
import '../components/drawer.dart';
import '../components/top_nav_bar.dart';
import '../components/bot_nav_bar.dart';

/*Class Landing Paged Logged
Landing Page for a user that is currently logged in
 */
class LandingPageLogged extends StatefulWidget {
  const LandingPageLogged({Key key}) : super(key: key);
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
      appBar: Top_Nav_Bar(),
      drawer: SideDrawer(),
      body: _buildBody(),
      bottomNavigationBar: Bot_Nav_Bar(),
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
    Expanded(child: Container(width: 360, child: _buildBox()))
  ]));
}

Widget _buildBox() {
  return Container(
    child: Column(
      children: [
        TextFormField(
            decoration: InputDecoration(
                labelText: 'Enter a catchy Title',
                labelStyle: TextStyle(color: Colors.green))),
        TextFormField(
            decoration: InputDecoration(
          labelText: 'Enter comment here',
          labelStyle: TextStyle(color: Colors.green),
        ))
      ],
    ),
  );
}
