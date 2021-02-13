import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:treat_yoself/controllers/controllers.dart';

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
  runApp(App());
}
