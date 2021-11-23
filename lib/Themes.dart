import 'package:ecommerce/Helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Themes {

  static final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: MyColors.bgColor,
      textTheme: TextTheme(bodyText1: TextStyle(fontSize: 16, fontFamily: MyFonts.Bold, color: MyColors.color_Main, decoration: TextDecoration.none))),
    backgroundColor: MyColors.bgColor,
    cardColor: MyColors.cardColor,
    indicatorColor: MyColors.primaryColor,
    primaryTextTheme: TextTheme(
      caption: TextStyle(fontSize: 18, fontFamily: MyFonts.Medium, color: MyColors.primaryColor),
      bodyText1: TextStyle(fontSize: 14, fontFamily: MyFonts.Medium, color: MyColors.primaryColorLight),
      bodyText2: TextStyle(fontSize: 16, fontFamily: MyFonts.Bold, color: MyColors.primaryColor),
      subtitle1: TextStyle(fontSize: 12, fontFamily: MyFonts.Light, color: Colors.black),
      subtitle2: TextStyle(fontSize: 14, fontFamily: MyFonts.Regular, color: MyColors.primaryColorLight),
      headline1: TextStyle(fontSize: 16, fontFamily: MyFonts.Medium, color: Colors.black),
      headline2: TextStyle(fontSize: 14, fontFamily: MyFonts.Medium, color: Colors.white),
      headline3: TextStyle(fontSize: 14, fontFamily: MyFonts.Medium, color: MyColors.primaryColorLight),

    ),

  );

  static final ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
        color: MyColors.bgColorDark,
        textTheme: TextTheme(bodyText1: TextStyle(fontSize: 16, fontFamily: MyFonts.Bold, color: MyColors.color_Main, decoration: TextDecoration.none)),
  ),
    backgroundColor: MyColors.bgColorDark,
    cardColor: MyColors.cardColorDark,
    indicatorColor: MyColors.primaryColor2,
    primaryTextTheme: TextTheme(
      caption: TextStyle(fontSize: 18, fontFamily: MyFonts.Medium, color: MyColors.primaryColor2),
      bodyText1: TextStyle(fontSize: 14, fontFamily: MyFonts.Medium, color: MyColors.boulder),
      bodyText2: TextStyle(fontSize: 16, fontFamily: MyFonts.Bold, color: MyColors.primaryColor2),
      subtitle1: TextStyle(fontSize: 12, fontFamily: MyFonts.Light, color: MyColors.boulder),
      subtitle2: TextStyle(fontSize: 14, fontFamily: MyFonts.Regular, color: MyColors.boulder),
      headline1: TextStyle(fontSize: 16, fontFamily: MyFonts.Medium, color: MyColors.primaryColor2),
      headline2: TextStyle(fontSize: 14, fontFamily: MyFonts.Medium, color: MyColors.primaryColor2),
      headline3: TextStyle(fontSize: 14, fontFamily: MyFonts.Medium, color: MyColors.boulder),
    ),

  );

  ThemeMode getThemeMode() {
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void changeThemeMode() {
    //isDark =!isDark;
    if(isDark == null){
      isDark = false;
    }
    ThemeMode themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode);
  }
}