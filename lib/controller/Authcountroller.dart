import 'package:aqhealth/config/config.dart';
import 'package:http/http.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:aqhealth/constant/headers.dart';

class Auth {
  static Future<dynamic> register(
      {required String email,
      required String ic,
      required String password}) async {
    try {
      String url = '${Config.hostName}/register';

      var response = await post(Uri.parse(url),
          body: jsonEncode({
            'email': email,
            'ic': ic,
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
}
