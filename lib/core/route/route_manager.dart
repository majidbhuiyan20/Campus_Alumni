import 'package:flutter/material.dart';
import '../../presentation/bottom_nav/view/bottom_nav_bar_screen.dart';
import '../../presentation/splash/view/splash_screen.dart';
import '../resource/app_strings.dart';

class Routes{
  static const String splashRoute="/";
  static const String bottomNavBarRoute="/bottomNavbarRoute";
  static const String loginRoute="/loginScreen";

}
class RouteGenerator{
  static Route<dynamic>getRoute(RouteSettings routeSettings){
    switch (routeSettings.name) {
      case Routes.splashRoute:
      return MaterialPageRoute(builder: (_)=> SplashScreen());
case Routes.bottomNavBarRoute:
      return MaterialPageRoute(builder: (_)=> BottomNavBarScreen());

      default:
      return unDefineRoute();
    }

  }
  static Route<dynamic>unDefineRoute(){
    return MaterialPageRoute(builder: (_)=>Scaffold(
      appBar: AppBar(title: Text(AppString.noRoute),),
      body: Center(child: Text(AppString.noRoute),),
    ));
  }
}