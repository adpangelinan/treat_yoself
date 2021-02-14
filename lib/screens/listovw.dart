import 'package:flutter/material.dart';
import 'package:treat_yoself/constants/app_routes.dart';
import 'package:treat_yoself/localizations/localizations.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'package:treat_yoself/screens/components/components.dart';
import 'package:treat_yoself/screens/screens.dart';
import 'package:get/get.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';
import 'auth/auth.dart';
import '../utils/entities/shoppinglist.dart';

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
              appBar: TopNavBar(title: "Cart",),
              drawer: SideDrawer(),
              body: listovwBody(context, controller.firestoreUser.value.uid),
              bottomNavigationBar: Bot_Nav_Bar(),
            ),
    );
  }

  Widget listovwBody(BuildContext context, String uid) {
    print("user is $uid");

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

    return GridView.extent(
        maxCrossAxisExtent: 150,
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

  Container editNewListTile() {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 10, color: Colors.blueAccent),
            borderRadius: const BorderRadius.all(const Radius.circular(8))),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {});
              }),
          FittedBox(fit: BoxFit.fitWidth, child: Text("Create New List"))
        ]));
  }

  Container addNewListTile(String fuid) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 10, color: Colors.blueAccent),
            borderRadius: const BorderRadius.all(const Radius.circular(8))),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _shoppingListController.addList("my new test list", fuid);
                setState(() {});
              }),
          FittedBox(fit: BoxFit.fitWidth, child: Text("Create New List"))
        ]));
  }

  List<Container> existingShoppingLists(int count, List<sList> userLists) =>
      List.generate(
          count,
          (i) => Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 10, color: Colors.blueAccent),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(8))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          setState(() {
                            //listToSend = shoppinglists[i].getListName();
                          });
                        }),
                    FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(userLists[i].getListName()))
                  ])));
}

Widget topNavBar(BuildContext context) {
  final labels = AppLocalizations.of(context);
  return AppBar(
    title: Text(labels?.home?.title),
    actions: [
      IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            //Get.to(ShoppingCart());
          }),
      IconButton(
          icon: Icon(Icons.camera_alt_outlined),
          onPressed: () {
            //Get.to(CameraPage());
          }),
      IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Get.to(SettingsUI());
          }),
    ],
  );
}

Widget botNavBar(BuildContext context) {
  return BottomAppBar(
      color: Colors.white,
      child: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Get.to(HomeUI());
          }));
}

Widget mainDrawer(BuildContext context) {
  return Drawer(
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
            Get.to(AccountDetails());
          },
        ),
        ListTile(
          //leading: NewsTab.androidIcon,
          title: Text('Shopping List'),
          onTap: () {
            Get.to(ListOverviewUI());
          },
        ),
        ListTile(
          //leading: ProfileTab.androidIcon,
          title: Text('Find Items'),
          onTap: () {
            //Get.to(ItemSearchTab());
          },
        ),
        ListTile(
          //leading: SettingsTab.androidIcon,
          title: Text("Shop Categories"),
          onTap: () {
            //Get.to(CategoriesTab());
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
            Get.to(SettingsUI());
          },
        ),
      ],
    ),
  );
}
