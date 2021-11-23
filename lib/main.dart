import 'package:ecommerce/Helper.dart';
import 'package:ecommerce/Themes.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onGenerateRoute: Routes.generateRoute,
      initialRoute: MyRoutes.initialRoute,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: Themes().getThemeMode(),
    );
  }
}

