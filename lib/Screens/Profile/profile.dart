import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:docokana_new_app_mk2/Screens/Information.dart';
import 'package:docokana_new_app_mk2/Screens/Profile/EditProfile.dart';
import 'package:docokana_new_app_mk2/Screens/Profile/settings.dart';
import 'package:docokana_new_app_mk2/models/data_model.dart';
import 'package:docokana_new_app_mk2/util/color.dart';
import 'package:docokana_new_app_mk2/api/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

List adds = [
  {
    'icon': Icons.whatshot,
    'color': Colors.indigo,
    'title': "Get matches faster",
    'subtitle': "Boost your profile once a month",
  },
  {
    'icon': Icons.favorite,
    'color': Colors.lightBlueAccent,
    'title': "more likes",
    'subtitle': "Get free rewindes",
  },
  {
    'icon': Icons.star_half,
    'color': Colors.amber,
    'title': "Increase your chances",
    'subtitle': "Get unlimited free likes",
  },
  {
    'icon': Icons.location_on,
    'color': Colors.purple,
    'title': "Swipe around the world",
    'subtitle': "Passport to anywhere with hookup4u",
  },
  {
    'icon': Icons.vpn_key,
    'color': Colors.orange,
    'title': "Control your profile",
    'subtitle': "highly secured",
  }
];

class Profile extends StatefulWidget{
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static Map<String, dynamic> user = Map();

  @override
  void initState(){
    super.initState();
    getUser();
  }

  Future getUser() async {
    var url = Url().url + "get_user";
    var response = await http.get(url);
    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);

      setState(() {
        user = jsonData;
      });
      return jsonData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50)),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 5),
              child: InkWell(
                onTap: () => showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Info(currentUser);
                    }),
                child: CircleAvatar(
                  backgroundColor: secondryColor,
                  radius: 90,
                  backgroundImage: currentUser.imageUrl.length > 0
                      ? AssetImage(currentUser.imageUrl[0])
                      : null,
                ),
              ),
            ),
            Text(
              "${user['name']}",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
            Text(
              "${user['email']}",
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * .5,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 70,
                            width: 70,
                            child: FloatingActionButton(
                                heroTag: UniqueKey(),
                                splashColor: secondryColor,
                                backgroundColor: primaryColor,
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                onPressed: () {
                                  source(context);
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Add media",
                              style: TextStyle(color: secondryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 30, top: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            FloatingActionButton(
                                splashColor: secondryColor,
                                heroTag: UniqueKey(),
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.settings,
                                  color: secondryColor,
                                  size: 28,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => Settings()));
                                }),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Settings",
                                style: TextStyle(color: secondryColor),
                              ),
                            )
                          ],
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(right: 30, top: 30),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: <Widget>[
                            FloatingActionButton(
                                heroTag: UniqueKey(),
                                splashColor: secondryColor,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.edit,
                                  color: secondryColor,
                                  size: 28,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => EditProfile()));
                                }),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Edit Info",
                                style: TextStyle(color: secondryColor),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 230),
                    child: Container(
                      height: 120,
                      child: CustomPaint(
                        painter: CurvePainter(),
                        size: Size.infinite,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = secondryColor.withOpacity(.4);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1.5;

    var startPoint = Offset(0, -size.height / 2);
    var controlPoint1 = Offset(size.width / 4, size.height / 3);
    var controlPoint2 = Offset(3 * size.width / 4, size.height / 3);
    var endPoint = Offset(size.width, -size.height / 2);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

source(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            "Select source",
          ),
          insetAnimationCurve: Curves.decelerate,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.photo_camera,
                    size: 28,
                  ),
                  Text(
                    " Camera",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.photo_library,
                    size: 28,
                  ),
                  Text(
                    " Gallery",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
            ),
          ],
        );
      });
}
