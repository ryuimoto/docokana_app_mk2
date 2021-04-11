import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:docokana_new_app_mk2/Screens/Tab.dart';
import 'package:docokana_new_app_mk2/Screens/auth/login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context, CupertinoPageRoute(builder: (context) => Tabbar()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
              height: 120,
              width: 200,
              child: SvgPicture.asset(
                "asset/hookup4u-Logo-BP.svg",
                fit: BoxFit.contain,
              )),
        ));
  }
}
