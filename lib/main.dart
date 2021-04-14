import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:docokana_new_app_mk2/Screens/Splash.dart';
import 'package:docokana_new_app_mk2/util/color.dart';
import 'package:docokana_new_app_mk2/Screens/auth/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: Splash(),
      // home: Login(),
    );
  }
}
