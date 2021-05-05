import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:docokana_new_app_mk2/Screens/Tab.dart';
import 'package:docokana_new_app_mk2/Screens/auth/login.dart';
import 'package:http/http.dart';
import 'package:docokana_new_app_mk2/api/url.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';
import 'dart:convert';


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
    loginState();
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

    void loginState() async {
      String deviceId = '';

      if(Platform.isAndroid) {
        print('android!!');
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = '${androidInfo.androidId}';

      } else if(Platform.isIOS) {
        print('ios!!');
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        deviceId = '${iosDeviceInfo.identifierForVendor}';

      }

      print(deviceId);

      String url = Url().url + 'get_user';
      Map<String, String> headers = {'content-type': 'application/json'};
      String body = json.encode({
        'device_id': deviceId,
      });

      print(body);

    }
}
