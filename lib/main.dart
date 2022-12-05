import 'package:aqhealth/controller/Authcountroller.dart';
import 'package:aqhealth/model/patient.dart';
import 'package:aqhealth/pages/authentication/Authenticate.dart';
import 'package:aqhealth/pages/authentication/login.dart';
import 'package:aqhealth/pages/dashboard/mainpage.dart';
import 'package:aqhealth/pages/dashboard/wrapper.dart';
import 'package:aqhealth/pages/profile/complete_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aqhealth/widget/loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      );
    });
  }
}
