import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecommerce/Helper.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: getBody()),
    );
  }

  @override
  void initState() {
    Rout();
    gotoHome();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  gotoHome() async {
    await new Future.delayed(const Duration(seconds: 5));
/*    Navigator.pushNamedAndRemoveUntil(
        context, MyRoutes.home, (Route<dynamic> route) => false);*/
    Get.offAllNamed(MyRoutes.home);
  }


  getBody() {
    return Center(
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 40.0,
          color: MyColors.primaryColor
        ),
        child: AnimatedTextKit(
            animatedTexts: [
              RotateAnimatedText('E-Commerce')
            ]
      ),
    ),
    );
  }

}

