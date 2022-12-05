import 'package:aqhealth/pages/authentication/login.dart';
import 'package:aqhealth/pages/authentication/register.dart';
import 'package:flutter/material.dart';


class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return UserLogin(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
