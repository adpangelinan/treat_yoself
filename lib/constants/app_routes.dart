import 'package:get/get.dart';
import 'package:treat_yoself/screens/screens.dart';
import 'package:treat_yoself/utils/entities/authentication_service.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => SplashTab()),
    GetPage(name: '/signin', page: () => LoginPage()),
    GetPage(name: '/signup', page: () => Registration()),
    GetPage(name: '/landing_page', page: () => LandingPageLogged()),
    GetPage(name: '/account', page: () => UserSettings()),
    GetPage(name: '/shopping_list', page: () => ShoppingList()),
    GetPage(name: '/category', page: () => Category()),
    GetPage(name: '/results', page: () => Results()),
  ];
}
