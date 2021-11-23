import 'package:ecommerce/Themes.dart';
import 'package:ecommerce/screens/Home.dart';
import 'package:ecommerce/screens/ProductDetails.dart';
import 'package:ecommerce/screens/Splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Helper.dart';

abstract class MyRoutes {
  static const initialRoute = "/";
  static const home = "/home";
  static const productDetails = "/productDetails";
}

class Rout{
  Rout(){
    setThemeData();
  }
}

Future<void> setThemeData() async {
  SharedPreferences sharedPreferences = await getShared();
  bool theme = sharedPreferences.get("theme");
  if (theme != null) {
    isDark = theme;
  }else{
    try{
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      isDark = brightness == Brightness.dark;
    }catch(e){

    }
  }

  Themes().changeThemeMode();
}

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    var name = settings.name;
    final args = settings.arguments;

    switch (name) {
      case MyRoutes.initialRoute:
        return PageTransition(child: Splash(), settings: settings, type: PageTransitionType.fade);

      case MyRoutes.home:
        return PageTransition(child: Home(), settings: settings, type: PageTransitionType.topToBottom);

      case MyRoutes.productDetails:
        return PageTransition(child: ProductDetails(args), settings: settings, type: PageTransitionType.bottomToTop);
    }

  }
}
