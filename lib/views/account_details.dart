import 'package:flutter/material.dart';
import 'package:treat_yoself/controllers/rewards_controller.dart';
import 'package:treat_yoself/localizations/localizations.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'views.dart';
import 'package:get/get.dart';
import 'auth/auth.dart';

class AccountDetails extends StatelessWidget {
  final rewardsController = Get.put(RewardsController());
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller?.firestoreUser?.value?.uid == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: TopNavBar(
                title: "Account",
              ),
              bottomNavigationBar: BotNavBar(),
              body: accountDetailsBody(context, controller, rewardsController)),
    );
  }

  Widget accountDetailsBody(
      BuildContext context, authcontroller, rewardscontroller) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: TabBar(
              tabs: [
                Tab(
                    icon: Icon(Icons.account_circle,
                        color: context.theme.accentColor)),
                Tab(
                    icon:
                        Icon(Icons.bar_chart, color: context.theme.accentColor))
              ],
            ),
            body: TabBarView(
              children: [
                Container(
                    child: Column(children: [
                  Expanded(child: _buildUserDetails(authcontroller)),
                ])),
                Container(
                    child: Column(
                  children: [Expanded(child: _buildUserStats(authcontroller))],
                ))
              ],
            )));
  }

  Widget _buildUserStats(authcontroller) {
    return Center(
      child: Column(children: <Widget>[
        SizedBox(height: 20),
        Avatar(authcontroller.firestoreUser.value),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FormVerticalSpace(),
            Text('Points: ' + rewardsController.getPoints().toString(),
                style: TextStyle(fontSize: 16)),
            FormVerticalSpace(),
            Text('Title: ' + rewardsController.calcLevel().toString(),
                style: TextStyle(fontSize: 16)),
            FormVerticalSpace(),
          ],
        )
      ]),
    );
  }

  Widget _buildUserDetails(
    authcontroller,
  ) {
    return Center(
      child: Container(
        height: 450,
        child: Column(children: <Widget>[
          SizedBox(height: 20),
          Avatar(authcontroller.firestoreUser.value),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormVerticalSpace(),
              Text('Username: ' + authcontroller.firestoreUser.value.username,
                  style: TextStyle(fontSize: 12)),
              FormVerticalSpace(),
              Text('Name: ' + authcontroller.firestoreUser.value.name,
                  style: TextStyle(fontSize: 12)),
              FormVerticalSpace(),
              Text('Email: ' + authcontroller.firestoreUser.value.email,
                  style: TextStyle(fontSize: 12)),
              FormVerticalSpace(),
              Text('Admin Access: ' + authcontroller.admin.value.toString(),
                  style: TextStyle(fontSize: 12)),
              FormVerticalSpace(),
              Text('ZipCode: ' + authcontroller.firestoreUser.value.zipcode,
                  style: TextStyle(fontSize: 12)),
              FormVerticalSpace(),
              RaisedButton(
                  onPressed: () {
                    Get.to(UpdateProfileUI());
                  },
                  child: Text('Edit Profile'))
            ],
          )
        ]),
      ),
    );
  }
}
