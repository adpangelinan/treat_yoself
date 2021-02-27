import 'package:flutter/material.dart';
import 'package:treat_yoself/localizations/localizations.dart';
import 'package:treat_yoself/controllers/controllers.dart';
import 'views.dart';
import 'package:get/get.dart';
import 'auth/auth.dart';

class AccountDetails extends StatelessWidget {
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
              drawer: SideDrawer(),
              bottomNavigationBar: BotNavBar(),
              body: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 120),
                    Avatar(controller.firestoreUser.value),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FormVerticalSpace(),
                        Text(
                            'Username: ' +
                                controller.firestoreUser.value.username,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        Text('Name: ' + controller.firestoreUser.value.name,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        Text('Email: ' + controller.firestoreUser.value.email,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        Text(
                            'Admin Access: ' +
                                controller.admin.value.toString(),
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        Text(
                            'ZipCode: ' +
                                controller.firestoreUser.value.zipcode,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        RaisedButton(
                            onPressed: () {
                              Get.to(UpdateProfileUI());
                            },
                            child: Text('Edit Profile'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
