import 'package:aqhealth/pages/authentication/login.dart';
import 'package:aqhealth/pages/authentication/register.dart';
import 'package:aqhealth/pages/dashboard/mainpage.dart';
import 'package:aqhealth/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Mainpage(),
      );
    });
  }
}
