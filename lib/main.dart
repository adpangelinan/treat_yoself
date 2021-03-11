import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:treat_yoself/controllers/controllers.dart';
import 'package:treat_yoself/controllers/rewards_controller.dart';

import 'routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());
  Get.put<ShoppingListController>(ShoppingListController());
  Get.put<SearchController>(SearchController());
  Get.put<RewardsController>(RewardsController());
  runApp(App());
}
