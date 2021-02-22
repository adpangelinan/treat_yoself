import 'package:get/get.dart';
import 'package:treat_yoself/views/views.dart';
import 'package:treat_yoself/utils/entities/authentication_service.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => SplashTab()),
    GetPage(name: '/signin', page: () => SignIn()),
    GetPage(name: '/signup', page: () => Registration()),
    //GetPage(name: '/landing_page', page: () => LandingPageLogged()),
    GetPage(name: '/account', page: () => AccountDetails()),
    GetPage(name: '/shopping_list', page: () => ListOverviewUI()),
    GetPage(name: '/category', page: () => Category()),
    //GetPage(name: '/results', page: () => Results()),
    GetPage(name: '/home', page: () => HomeUI()),
    //Add settings page.
  ];
}
