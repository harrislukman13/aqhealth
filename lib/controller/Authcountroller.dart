import 'package:aqhealth/config/config.dart';
import 'package:aqhealth/controller/DatabaseController.dart';
import 'package:aqhealth/model/patient.dart';
import 'package:http/http.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:aqhealth/constant/headers.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  get userID => _auth.currentUser?.uid;

  //sign in
  Future singIn(String email, String password) async {
    try {
      UserCredential? result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future register(
      String email,
      String password,
      String name,
      String ic,
      String phonenum,
      String gender,
      String address,
      String state,
      String url) async {
    try {
      UserCredential? result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseController(uid: user!.uid).updateUserData(Patient(
        role: 'Patient',
        name: name,
        ic: ic,
        gender: gender,
        phonenum: phonenum,
        address: address,
        state: state,
        url: url,
      ));
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

/*
  register(
      {required String email,
      required String name,
      required String password}) async {
    try {
      String url = '${Config.hostName}/register';

      var response = await post(Uri.parse(url),
          body: jsonEncode({
            'name': name,
            'email': email,
            'password': password,
          }),
          headers: headersWithoutToken());

      log(response.body);

      if (response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }

      return null;
    } catch (e) {
      log('register' + e.toString());
      return null;
    }
  }

  login({required String email, required String password}) async {
    try {
      String url = '${Config.hostName}/login';

      var response = await post(Uri.parse(url),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: headersWithoutToken());

      log(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }

      return null;
    } catch (e) {
      log('login' + e.toString());
      return null;
    }
  }
  */
}
