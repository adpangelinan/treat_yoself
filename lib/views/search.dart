import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:treat_yoself/controllers/rewards_controller.dart';
import 'package:treat_yoself/localizations/localizations.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'views.dart';
import 'package:get/get.dart';
import 'auth/auth.dart';
import 'item_location_services.dart';
import '../utils/database/db_utils.dart';

class SearchUI extends StatefulWidget {
  @override
  _SearchUIState createState() => _SearchUIState();
}

class _SearchUIState extends State<SearchUI> {
  final searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller?.firestoreUser?.value?.uid == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text("Search"),
              ),
              body: searchBody(context),
              bottomNavigationBar: BotNavBar(),
            ),
    );
  }

  Widget searchBody(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;
    double c_height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: c_width, minHeight: c_height),
          child: IntrinsicHeight(
              child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(
              children: [FormVerticalSpace()],
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Find an Item",
                  textAlign: TextAlign.center,
                )),
              ],
            ),
            Row(
              children: [FormVerticalSpace()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: c_width * 0.8,
                    height: c_width * 0.2,
                    child: FormInputField(
                      controller: searchController.searchTextBox,
                      onChanged: (value) => null,
                      onSaved: (value) =>
                          searchController.searchTextBox.text = value,
                    )),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: c_width * 0.2,
                    child: FlatButton(
                      child: Text('Find Item'),
                      onPressed: () {
                        searchController.search();
                        FocusScope.of(context).unfocus();
                        setState(() {});
                      },
                    ),
                  ),
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      searchController.searchTextBox.clear();
                      searchController.clearSearch();
                      setState(() {});
                      FocusScope.of(context).unfocus();
                    },
                  )
                ]),
            buildList(),
          ])),
        ));
  }

  Widget buildList() {
    //find length
    int listLength = searchController.foundArr.length;

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: searchController.searchHasResults
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: listLength,
                itemBuilder: (context, index) {
                  return buildCards(searchController.foundArr[index]);
                },
              )
            : Center(
                child: Text(
                "No Items Found",
                style: TextStyle(fontSize: 50.00),
              )));
  }

  Widget buildCards(SearchItem item) {
    bool brandsFound = false;
    if (item.brands.length > 0) {
      brandsFound = true;
    }
    return item.clicked
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildItem(item),
              brandsFound
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: item.brands.length,
                      itemBuilder: (context, i) {
                        return Container(child: buildBrandCard(item.brands[i]));
                      },
                    )
                  : Container(child: buildGenericBrandCard())
            ],
          )
        : buildItem(item);
  }

  //card for the item name itself
  Widget buildItem(SearchItem item) => Card(
      child: Material(
          child: InkWell(
        onTap: () {
          searchController.clickItem(item);
          setState(() {});
        },
        splashColor: Colors.white,
        child: ListTile(
          title: Text(item.name),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Tap to find brands."),
            ],
          ),
        ),
      )),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)));

  Widget buildBrandCard(BrandSearchItem item) => Card(
      color: Colors.green.shade900,
      child: Material(
          child: InkWell(
        onTap: () => null,
        splashColor: Colors.white,
        child: ListTile(
          title: Text(item.brandName),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart_sharp),
            tooltip: 'Add Item',
            onPressed: () => _popUp(context, item.brandItemID.toString()),
          ),
        ),
      )),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)));

  Widget buildGenericBrandCard() => Card(
      color: Colors.green.shade900,
      child: Material(
          child: InkWell(
        onTap: () => null,
        splashColor: Colors.white,
        child: ListTile(
          title: Text("Generic"),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart_sharp),
            tooltip: 'Add Item',
            onPressed: () => null,
          ),
        ),
      )),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)));

  _popUp(context, String itemID) async {
    //add insert query, returns 0 if successful, 1 if failure
    var successful = await searchController.addItem(itemID);

    if (successful == 0) {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Item Added To Cart"),
                actions: [
                  TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              ));
    } else {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                    "Error: Shopping List is not set to add item to\nPlease select a shopping list in shopping lists view"),
                actions: [
                  TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              ));
    }
  }
}
