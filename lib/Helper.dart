import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/Themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum requestResponseState { Error, Success, Loading}

List productList = [];

bool isDark = false;

addStreamEvent(var event, StreamController controller) {
  if (!controller.isClosed) {
    controller.add(event);
  }
}

abstract class MyFonts {
  static const Regular = 'Regular';
  static const Light = 'Light';
  static const Medium = 'Medium';
  static const Bold = 'Bold';
}

abstract class MyColors{
  static const Color color_Main = Colors.black;
  static const Color primaryColor = Color.fromRGBO(21, 24, 107, 1);
  static const Color primaryColor2 = Color.fromRGBO(250, 250, 250, 1);
  static const Color primaryColorLight = Color.fromRGBO(84, 92, 155, 1);
  static const Color boulder = Color.fromRGBO(187, 187, 187, 1);
  static const Color bgColor = Color.fromRGBO(231, 236, 240, 1);
  static const Color bgColorDark = Color.fromRGBO(45, 45, 45, 1);
  static const Color cardColor = Colors.white;
  static const Color cardColorDark = Color.fromRGBO(72, 72, 74, 1);
  static const Color lightYellow = Color.fromRGBO(255, 223, 0, 0.4);
  static const Color darkYellow = Color.fromRGBO(255, 223, 0, 0.7);
  static const Color grey = Color.fromRGBO(211, 211, 211, 0.7);
  static const Color greyLight = Color.fromRGBO(228, 228, 228, 0.7);

}

Map<String, String> requestHeaders = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

getShared() async {
  var _prefs = await SharedPreferences.getInstance();
  return _prefs;
}

setTheme() async {
  isDark =!isDark;
  Themes().changeThemeMode();
  SharedPreferences sharedPreferences = await getShared();
  sharedPreferences.setBool('theme', isDark);
}

Future getRequest(String url) async {
  var uri = Uri.parse(url);
  var response =
  await http.get(uri).timeout(const Duration(seconds: 30), onTimeout: () {
    return null;
  });
  if (response == null) {
    return 'No Data';
  }
  if (response.statusCode != 200) {
    return null;
  }
  var toJsonData = jsonDecode(response.body);
  if (toJsonData == null) {
    return null;
  } else {
    return toJsonData;
  }
}

Widget createTextThemeWise(
    {@required String label,
      @required var style,
      int maxLines = 50,
      TextAlign textAlign = TextAlign.left}) {

  return Text(
    label,
    style: style,
    maxLines: maxLines,
    textAlign: textAlign,
    textScaleFactor: 1.0,
  );
}

Widget createText(String label, double size,
    {Color color = MyColors.color_Main,
      String fontFamily = MyFonts.Regular,
      TextAlign textAlign = TextAlign.left,
      var softWrap = true,
      var maxLines = 50,
      var underLine = TextDecoration.none}) {

  return Text(label,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: fontFamily,
          decoration: underLine),
      softWrap: softWrap,
      maxLines: maxLines);
}