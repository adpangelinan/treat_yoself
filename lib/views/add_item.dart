import 'package:flutter/material.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'views.dart';
import 'package:get/get.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';

class MyCustomForm extends StatefulWidget {
  //final int user;
  MyCustomForm({this.barcode = ""});
  final barcode;
  @override
  MyCustomFormState createState() => MyCustomFormState();
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final fieldText = TextEditingController();
  final othertext = TextEditingController();
  final pricetext = TextEditingController();
  final storenametext = TextEditingController();
  final RewardsController rewards = Get.find();
  var list = <DropdownMenuItem<String>>[];
  var dblist = [];
  var category = "Dairy";
  var checkboxval = false;
  var dbConn = DatabaseEngine();
  var query = "SELECT Distinct Name from Categories;";
  var bartext;
  @override
  initState() {
    super.initState();
    getDBData();
    if (widget.barcode == null) {
      bartext = TextEditingController(text: "NONE");
    }
    else{
      bartext = TextEditingController(text: widget.barcode);
    }
  }

  void getDBData() async {
    var res = await dbConn.manualQuery(query);

    setState(() {
      for (var i in res) {
        list.add(DropdownMenuItem<String>(
            child: Text(i.values[0]), value: i.values[0]));
      }
      category = list[0].value;
    });
  }

  void clearText() {
    fieldText.clear();
    othertext.clear();
    pricetext.clear();
    storenametext.clear();
    bartext.clear(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add New Item")),
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
                  if (value.isEmpty || value == "") {
                    return "Please enter item Bar Code";
                  }
                  dblist.add(value);
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Enter Bar code here',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                controller: bartext),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  "Item On Sale?",
                  style: TextStyle(color: Colors.green),
                ),
                Checkbox(
                  value: checkboxval,
                  onChanged: (value) {
                    setState(() {
                      checkboxval = value;
                    });
                  },
                ),
              ])),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.extended(
                  heroTag: "bt2",
                  label: Text('Submit'),
                  icon: Icon(Icons.add),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(ctx).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                      dblist.add(category);
                      dblist.add(checkboxval);
                      print(dblist);
                      clearText();
                      var test = await addData();
                      if (test) {
                        //reward points
                        rewards.userUpdatesList();
                        dblist = [];
                        Scaffold.of(ctx).showSnackBar(SnackBar(
                          content: Text("Data Sent"),
                        ));
                      } else {
                        dblist = []; 
                        Scaffold.of(ctx).showSnackBar(SnackBar(
                          content: Text("Data failed to send or Barcode exists"),
                        )
                        );
                        dblist = []; 
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
                  heroTag: "bt1",
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
    var insertbranditems =
        "Insert Ignore into BrandsItems (BrandID,ItemID,BarCode) Values(?,?,?);";
    var selectstoreID = "Select StoreID from Stores Where Stores.ZipCode = ? and Stores.Name = ?;";
    var insertstoreitems =
        "Insert into StoresItems (Inventory,BrandItemID,StoreID) Values(?,?,?);";
    var insertprices =
        "Insert into Prices (StoreItemID,Price,DateAdded,UserID,OnSale) Values(?,?,?,?,?);";
    final AuthController controller = Get.find();
    var currentzip = controller.firestoreUser.value.zipcode;
    final uid = controller.firestoreUser.value.uid;
    var newuid = await database
        .manualQuery("Select UserID from Users Where fuid = ?", [uid]);
    var catname = dblist[5];
    var brandname = dblist[1];
    var itemname = dblist[0];
    var itemprice = dblist[2];
    var box;
    if (dblist[6] == false) {
      box = "0";
    } else {
      box = "1";
    }
    var catID;
    var now = DateTime.now();
    var date = DateTime(now.year, now.month, now.day).toString();
    catID = await database.manualQuery(selectcatquery, [catname]);
    if(catID.length == 0){
      return false;
    }
    var result;
    var itemID;
    result = await database
        .manualQuery(insertitem, [itemname, catID[0].values[0].toString()]);
    if(database.insertID != null){
    itemID = database.insertID; }
    else return false; 
    var brandID;
    result = await database.manualQuery(insertbrand, [brandname]);
       if(database.insertID != null){
    brandID = database.insertID; }
    else return false; 

    result = await database.manualQuery(
        insertbranditems, [brandID, itemID,dblist[4]]);
    var branditemid;
    if(database.insertID != null && database.insertID != 0){
      branditemid = database.insertID; }
    else if(result.length == 0){
      result = await database.manualQuery("Select BrandItemID from BrandsItems where BrandsItems.BrandID = ? and BrandsItems.ItemID = ? ",[brandID,itemID]);
      if(result.length != 0){
        branditemid = result[0].values[0];
      }
      else return false; 
    }
    else return false; 

    var storeID = await database.manualQuery(selectstoreID, [currentzip,dblist[3]]);

    if(storeID.length == 0){
      return false; 

    }

    result = await database.manualQuery(insertstoreitems,
        ["1", branditemid, storeID[0].values[0]]);
    var storeitemID; 
    if(database.insertID != null){
      storeitemID = database.insertID; }
    else return false; 

    result = await database.manualQuery(insertprices,
        [storeitemID, itemprice, date, newuid[0].values[0], box]);
    if(database.insertID != null){
     return true;}
    else return false; 
  }
}
