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
  const LandingPageLogged({Key key, this.user}) : super(key: key);
  final int user; //#TODO - make User Class
  @override
  _LandingPageLogged createState() => _LandingPageLogged();
  static String routeName = '/landing_page';
}

class _LandingPageLogged extends State<LandingPageLogged> {

  Widget build(BuildContext context) {
    //build a news feed list

    return Scaffold(
      appBar: Top_Nav_Bar(user: widget.user),
      drawer: SideDrawer(user: widget.user),
      body: _buildBody(widget.user),
      bottomNavigationBar: Bot_Nav_Bar(user: widget.user),
    );
  }

  void _pushRouteOptions() {
    Navigator.pushReplacementNamed(context, '/option');
  }
}

Widget _buildBody(int user) {

  
  return Container(
      child: Column(children: [
    Expanded(
        child: Row(children: [
      Container(width: 360, color: Colors.red, child: Feed())
    ])),
    Expanded(child: Container(width: 360, child: MyCustomForm(user)))
  ]));
}


class MyCustomForm extends StatefulWidget{
  final int user;
  MyCustomForm(this.user);
  @override 
  MyCustomFormState createState(){
    return MyCustomFormState(user);
  }
}

class MyCustomFormState extends State<MyCustomForm>{
  final _formKey = GlobalKey<FormState>();
  final fieldText = TextEditingController(); 
  final othertext = TextEditingController(); 
  final int user;

  MyCustomFormState(this.user);

  void clearText(){
    fieldText.clear(); 
    othertext.clear(); 
  }
  @override 
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildBox(_formKey,context,fieldText)
        ],));

  }

  Widget _buildBox(_formKey, context,fieldText) {
  return Expanded(child: Container(
    child: Column(
      children: [
        Text(widget.user.toString()),
        TextFormField(
            validator: (value){
              if(value.isEmpty){
                return 'Please enter some text';
              }
              return null; 
            },
            decoration: InputDecoration(
                labelText: 'Enter a catchy Title',
                labelStyle: TextStyle(color: Colors.green)),
            controller: fieldText ),
        TextFormField(
          validator: (value){
              if(value.isEmpty){
                return 'Please enter some text';
              }
              return null; 
            },
          decoration: InputDecoration(
          labelText: 'Enter comment here',
          labelStyle: TextStyle(color: Colors.green),
        ),
         controller: othertext),
        SizedBox(height: 10,),
        Row(
          children: [
          FloatingActionButton.extended(
            label: Text('Submit'),
            icon: Icon(Icons.add),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            onPressed: () {
            if( _formKey.currentState.validate()){
              
              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
              clearText();

            }
      
          },
        )
          ],)
        
      ],
    ),
  ));
}


}