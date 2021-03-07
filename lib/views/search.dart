import 'package:flutter/material.dart';
import 'package:treat_yoself/controllers/rewards_controller.dart';
import 'package:treat_yoself/localizations/localizations.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'views.dart';
import 'package:get/get.dart';
import 'auth/auth.dart';

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
              appBar: TopNavBar(
                title: "Search",
              ),
              drawer: SideDrawer(),
              body: searchBody(context),
              bottomNavigationBar: BotNavBar(),
            ),
    );
  }

  Widget searchBody(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.6;
    return Container(
        child: Column(children: [
      Text("Find an Item"),
      Container(
          width: c_width * 0.8,
          child: FormInputField(
            controller: searchController.searchTextBox,
            onChanged: (value) => null,
            onSaved: (value) => searchController.searchTextBox.text = value,
          )),
      Row(children: <Widget>[
        FlatButton(
          child: Text('Find Item'),
          onPressed: () {
            searchController.search();
          },
        ),
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            searchController.searchTextBox.clear();
          },
        )
      ]),
      Row(),
      Row(),
    ]));
  }
}
