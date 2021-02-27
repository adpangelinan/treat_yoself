import 'package:flutter/material.dart';
import 'package:treat_yoself/localizations/localizations.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'views.dart';
import 'package:get/get.dart';
import 'auth/auth.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';

class MyCustomForm extends StatefulWidget {
  //final int user;
  //MyCustomForm(this.user);
  @override
  MyCustomFormState createState() => MyCustomFormState();
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final fieldText = TextEditingController();
  final othertext = TextEditingController();
  final pricetext = TextEditingController();
  final zipcodetext = TextEditingController();
  final storenametext = TextEditingController();
  final list = [
    DropdownMenuItem<String>(
      child: Text("Dairy"),
      value: "Dairy",
    ),
    DropdownMenuItem<String>(
      child: Text("Meat"),
      value: "Meat",
    ),
    DropdownMenuItem<String>(
      child: Text("Pantry"),
      value: "Pantry",
    ),
    DropdownMenuItem<String>(
      child: Text("Fruits"),
      value: "Fruits",
    ),
    DropdownMenuItem<String>(
      child: Text("Vegetables"),
      value: "Vegetables",
    ),
    DropdownMenuItem<String>(
      child: Text("Frozen"),
      value: "Frozen",
    ),
    DropdownMenuItem<String>(
      child: Text("Bakery"),
      value: "Bakery",
    ),
    DropdownMenuItem<String>(
      child: Text("Seafood"),
      value: "Seafood",
    ),
    DropdownMenuItem<String>(
      child: Text("Beverages"),
      value: "Beverages",
    ),
    DropdownMenuItem<String>(
      child: Text("Deli"),
      value: "Deli",
    ),
    DropdownMenuItem<String>(
      child: Text("Personal Care"),
      value: "Personal Care",
    ),
    DropdownMenuItem<String>(
      child: Text("Condiments"),
      value: "Condiments",
    ),
    DropdownMenuItem<String>(
      child: Text("Cleaning"),
      value: "Cleaning",
    ),
    DropdownMenuItem<String>(
      child: Text("Baking"),
      value: "Baking",
    )
  ];
  var dblist = [];
  var category = "Dairy";

  void clearText() {
    fieldText.clear();
    othertext.clear();
    pricetext.clear();
    zipcodetext.clear();
    storenametext.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopNavBar(title: "Add New Item"),
        drawer: SideDrawer(),
        body: _buildBody(),
        //resizeToAvoidBottomPadding: false,
        bottomNavigationBar: BotNavBar());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Builder(
                builder: (ctx) => Column(
                      children: <Widget>[_buildBox(_formKey, ctx)],
                    ))));
  }

  Widget _buildBox(_formKey, ctx) {
    return Center(
        child: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Create a New Item",
              style: TextStyle(
                fontSize: 24.00,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
                decoration: InputDecoration(
                    labelText: "Select Item Category",
                    labelStyle: TextStyle(color: Colors.green)),
                items: list,
                style: TextStyle(fontSize: 15.00),
                value: category,
                onChanged: (value) {
                  setState(() {
                    category = value;
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  dblist.add(value);
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Enter Item Name',
                    labelStyle: TextStyle(color: Colors.green)),
                controller: fieldText),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please select valid category";
                  }
                  dblist.add(value);
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Enter Item Brand here',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                controller: othertext),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                validator: (value) {
                  final number = num.tryParse(value);
                  if (value.isEmpty) {
                    return "Please enter Price";
                  } else if (number == null) {
                    return "Please enter Price";
                  }
                  dblist.add(value);
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Enter Item Price here',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                controller: pricetext),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter Store Name";
                  }
                  dblist.add(value);
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Enter Store Name here',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                controller: storenametext),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                validator: (value) {
                  final number = num.tryParse(value);
                  if (value.isEmpty) {
                    return "Please enter Store Zip Code";
                  } else if (number == null || value.length != 5) {
                    return "Please enter a 5 digit number";
                  }
                  dblist.add(value);
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Enter Store Zip Code here',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                controller: zipcodetext),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.extended(
                  label: Text('Submit'),
                  icon: Icon(Icons.add),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(ctx).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                      dblist.add(category);
                      print(dblist);
                      clearText();
                      var test = await addData();
                      if (test) {
                        dblist = [];
                        Scaffold.of(ctx).showSnackBar(SnackBar(
                          content: Text("Data Sent"),
                        ));
                      } else {
                        Scaffold.of(ctx).showSnackBar(SnackBar(
                          content: Text("Data failed to send"),
                        ));
                      }
                    } else {
                      dblist = [];
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.extended(
                  label: Text('Reset'),
                  icon: Icon(Icons.sync),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {
                    clearText();
                  },
                ),
              )
            ],
          )
        ],
      ),
    ));
  }

  Future<bool> addData() async {
    var database = DatabaseEngine();
    var selectcatquery =
        "Select CategoryID from Categories Where Categories.Name = ?;";
    var insertitem = "Insert into Items (Name,CategoryID) Values(?,?);";
    var insertbrand = "Insert into Brands (Name) Values(?);";
    var selectbrandid = "Select BrandID from Brands Where Brands.Name = ?;";
    var insertbranditems =
        "Insert into BrandsItems (BrandID,ItemID) Values(?,?);";
    var selectitemID = "Select ItemID from Items Where Items.Name = ?";
    var catname = dblist[5];
    var brandname = dblist[2];
    var itemname = dblist[1];
    var catID;
    var brandID;
    var itemID;
    catID = await database.manualQuery(selectcatquery, [catname]);
    print(catID);
    var result;
    result = await database
        .manualQuery(insertitem, [itemname, catID[0].values[0].toString()]);
    print(result);
    result = await database.manualQuery(insertbrand, [brandname]);
    brandID = await database.manualQuery(selectbrandid, [brandname]);
    itemID = await database.manualQuery(selectitemID, [itemname]);
    result = await database.manualQuery(
        insertbranditems, [brandID[0].values[0], itemID[0].values[0]]);
    return true;
  }
}
