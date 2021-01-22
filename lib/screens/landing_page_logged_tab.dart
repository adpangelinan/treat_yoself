import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'login_tab.dart';


/*Class Landing Paged Logged
Landing Page for a user that is currently logged in
 */
class LandingPageLogged extends StatefulWidget {
  @override
  _LandingPageLogged createState() => _LandingPageLogged(); 
  static String routName = '/landing_page';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


 
}

class _LandingPageLogged extends State<LandingPageLogged>{



  Widget build(BuildContext context){  //build a news feed list 
    return Scaffold(
      appBar: AppBar(
        title: Text('Treat Yo Self')),
        drawer: Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Icon(
                Icons.account_circle,
                color: Colors.green.shade800,
                size: 96,
              ),
            ),
          ),
          ListTile(
            //leading: SongsTab.androidIcon,
            title: Text('Profile'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            //leading: NewsTab.androidIcon,
            title: Text('Shopping List'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            //leading: ProfileTab.androidIcon,
            title: Text('Find Items'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          // Long drawer contents are often segmented.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            
          ),
          ListTile(
            //leading: SettingsTab.androidIcon,
            title: Text("Settings"),
            onTap: () {
               Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    )
    ,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white ,
        child: IconButton(icon: Icon(Icons.home), onPressed: _pushRoute)),
        
    );

      //body: _,
  }

  void _pushRoute(){
    Navigator.pushReplacementNamed(context, '/landing_page');
  }

  void _pushRouteOptions(){
    Navigator.pushReplacementNamed(context, '/option');
    
  }



}
 