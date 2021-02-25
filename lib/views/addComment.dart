import 'package:flutter/material.dart';
import 'package:treat_yoself/localizations/localizations.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'views.dart';
import 'package:get/get.dart';
import 'auth/auth.dart';

class Comment extends StatefulWidget {
  //final int user;
  //MyCustomForm(this.user);
  @override
  _Comment createState() => _Comment();

}

class _Comment extends State<Comment> {
  final _formKey = GlobalKey<FormState>();
  final fieldText = TextEditingController();
  final othertext = TextEditingController();
  //final int user;

 // MyCustomFormState(this.user);

  void clearText() {
    fieldText.clear();
    othertext.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(title: "Categories"),
      drawer: SideDrawer(),
      body: _buildBody(),
      bottomNavigationBar: BotNavBar());
  }
  Widget _buildBody(){
    return Form(
        key: _formKey,
        child: Builder(builder:(ctx) => Column(
          children: <Widget>[_buildBox(_formKey,ctx)],
        )));
  }


  Widget _buildBox(_formKey, ctx) {
    return Expanded(
        child: Container(
      child: Column(
        children: [
          Text("Tell us about your Trip!"),
          TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Enter Store Name',
                  labelStyle: TextStyle(color: Colors.green)),
              controller: fieldText),
          TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Enter your comment here',
                labelStyle: TextStyle(color: Colors.green),
              ),
              controller: othertext),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              FloatingActionButton.extended(
                label: Text('Submit'),
                icon: Icon(Icons.add),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(ctx).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                    clearText();
                  }
                },
              )
            ],
          )
        ],
      ),
    ));
  }
}