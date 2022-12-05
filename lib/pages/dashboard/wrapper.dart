import 'package:aqhealth/pages/authentication/Authenticate.dart';
import 'package:aqhealth/pages/dashboard/mainpage.dart';
import 'package:aqhealth/widget/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aqhealth/model/patient.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Mainpage();
        } else {
          return Authenticate();
        }
      }),
    ));
}
