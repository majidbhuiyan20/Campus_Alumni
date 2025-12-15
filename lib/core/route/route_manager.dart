import 'package:campus_alumni/presentation/auth/view/login_screen.dart';
import 'package:campus_alumni/presentation/auth/view/wrapper.dart';
import 'package:flutter/material.dart';
import '../../presentation/bottom_nav/view/bottom_nav_bar_screen.dart';
import '../../presentation/splash/view/splash_screen.dart';
import '../resource/app_strings.dart';

class Routes{
  static const String wrapperRoute="/";
  static const String splashRoute="/splashRoute";
  static const String bottomNavBarRoute="/bottomNavbarRoute";
  static const String loginRoute="/loginScreen";

}
class RouteGenerator{
  static Route<dynamic>getRoute(RouteSettings routeSettings){
    switch (routeSettings.name) {
      case Routes.wrapperRoute:
      return MaterialPageRoute(builder: (_)=> Wrapper());
      case Routes.loginRoute:
      return MaterialPageRoute(builder: (_)=> LoginScreen());
      case Routes.bottomNavBarRoute:
      return MaterialPageRoute(builder: (_)=> BottomNavBarScreen());
      case Routes.splashRoute:
      return MaterialPageRoute(builder: (_)=> SplashScreen());

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