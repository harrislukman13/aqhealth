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
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('User');

    if (user == null) {
      return const Authenticate();
    } else {
      return FutureBuilder(
          future: users.doc((FirebaseAuth.instance.currentUser!).uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map data = (snapshot.data!.data() ?? {}) as Map;
              if (data['role'] == 'Patient' || data['role'] == 'patient') {
                return Mainpage(
                  data: data,
                  user: user,
                );
              }
            }
            return Loading();
          });
    }
  }
}
