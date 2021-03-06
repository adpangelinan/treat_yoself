import 'package:flutter/material.dart';
import 'package:treat_yoself/constants/app_routes.dart';
import 'package:treat_yoself/localizations/localizations.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';
import 'package:treat_yoself/views/views.dart';
import '../utils/entities/shoppinglist.dart';
import '../utils/entities/shoppingitem.dart';
import 'package:treat_yoself/helpers/helpers.dart';

class ListOverviewUI extends StatefulWidget {
  @override
  _ListOverviewState createState() => _ListOverviewState();
}

class _ListOverviewState extends State<ListOverviewUI> {
  final _shoppingListController = Get.put(ShoppingListController());

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
                title: "Cart",
              ),
              drawer: SideDrawer(),
              body: listovwBody(context, controller.firestoreUser.value.uid),
              bottomNavigationBar: BotNavBar(),
            ),
    );
  }

  Widget listovwBody(BuildContext context, String uid) {
    //Gets user lists based off the firestone user id
    List<sList> userLists = _shoppingListController.getUserLists(uid);

    return Container(
        child:
            Column(children: [Expanded(child: _buildTiles(userLists, uid))]));
  }

  Widget _buildTiles(List<sList> userLists, String fuid) {
    int count;
    if (userLists != null) {
      count = userLists.length;
    } else {
      count = 0;
    }
    double c_width = MediaQuery.of(context).size.width;
    return GridView.extent(
        maxCrossAxisExtent: c_width * 0.5,
        padding: const EdgeInsets.all(18),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: shoppingListTiles(count, userLists, fuid));
  }

  List<Container> shoppingListTiles(
      int count, List<sList> userLists, String fuid) {
    List<Container> tilesList, tilesList2;

    tilesList = [addNewListTile(fuid)];
    tilesList2 = existingShoppingLists(count, userLists);
    tilesList = tilesList + tilesList2;

    return tilesList;
  }

  Container addNewListTile(String fuid) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 4, color: Colors.blueAccent),
            borderRadius: const BorderRadius.all(const Radius.circular(8))),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _showMaterialDialog(fuid);
                //setState(() {});
              }),
          Align(
              alignment: Alignment.bottomCenter,
              child: FittedBox(
                  fit: BoxFit.fitWidth, child: Text("Create New List")))
        ]));
  }

  List<Container> existingShoppingLists(int count, List<sList> userLists) =>
      List.generate(
          count,
          (i) => Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.blueAccent),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(8))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.delete_outline_rounded),
                          onPressed: () {
                            _shoppingListController
                                .deleteList(userLists[i].listID);
                            setState(() {});
                          },
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: IconButton(
                            icon: Icon(Icons.shopping_cart_outlined),
                            onPressed: () {
                              _shoppingListController.setList(userLists[i]);
                              Get.to(ShoppingListView());
                            })),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(userLists[i].getListName())))
                  ])));

  _showMaterialDialog(String fuid) {
    double c_width = MediaQuery.of(context).size.width * 0.8;

    return showDialog(
        context: context,
        builder: (_) => new SimpleDialog(
              title: new Text("New Shopping List"),
              children: [
                Container(
                    padding: const EdgeInsets.all(8.0),
                    width: c_width,
                    child: Center(
                        child: Column(
                      children: [
                        Row(children: <Widget>[
                          Container(
                              width: c_width * 0.6,
                              child: Center(
                                  child: Text(
                                      "What would you like to name your shopping list?"))),
                        ]),
                        Row(children: <Widget>[
                          Container(
                              width: c_width * 0.8,
                              child: FormInputField(
                                controller:
                                    _shoppingListController.addListController,
                                onChanged: (value) => null,
                                onSaved: (value) => _shoppingListController
                                    .addListController.text = value,
                              )),
                        ]),
                        Row(children: <Widget>[
                          FlatButton(
                            child: Text('Add List'),
                            onPressed: () {
                              _shoppingListController.addList(context, fuid);

                              Navigator.of(context).pop();
                              _addListDialog();
                            },
                          ),
                          FlatButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              _shoppingListController.addListController.clear();
                              Navigator.of(context).pop();
                            },
                          )
                        ]),
                      ],
                    )))
              ],
            ));
  }

  _addListDialog() {
    double c_width = MediaQuery.of(context).size.width * 0.5;

    return showDialog(
        context: context,
        builder: (_) => new SimpleDialog(
              title: new Text("List Added"),
              children: [
                Container(
                    padding: const EdgeInsets.all(8.0),
                    width: c_width,
                    child: Center(
                        child: Column(children: [
                      Row(children: <Widget>[
                        Container(
                            width: c_width * 0.6,
                            child: Center(child: Text("New List Added"))),
                      ]),
                      Row(children: <Widget>[
                        FlatButton(
                            child: Text('OK'),
                            onPressed: () {
                              setState(() {});
                              Navigator.of(context).pop();
                            })
                      ]),
                    ])))
              ],
            ));
  }
}
