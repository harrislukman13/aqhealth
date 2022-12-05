/*import 'package:flutter/cupertino.dart';
import 'package:aqhealth/model/patient.dart';
import 'package:aqhealth/Services/secure_storage.dart';
import 'package:aqhealth/controller/Authcountroller.dart';

class PatientDAO extends ChangeNotifier {
  Patient? _user;

  UserDAO() {
    initData();
  }

  get user => _user;

  // GET DATA FROM CACHE FIRST IF ANY
  initData() async {
    SecureStorage _secureStorage = SecureStorage();
    String? _token = await _secureStorage.read('token');

    notifyListeners();
    //getLatestData(_token!, _user!.id!);
  }

  // OVERWRITE WITH NEW DATA
  //getLatestData(String token, String userID) async {
  //dynamic data = await AuthController.getProfile(userID);

  //  if (data != null) {
  //   Box _userBox = await Hive.openBox('user');
  //   _userBox.put(token, User.fromMap(data));
//
  //   _user = User.fromMap(data);
  //  notifyListeners();
  //  }
  //}

  // LOGIN
  login(String email, String password) async {
    AuthController auth = AuthController();
    dynamic data = await auth.login(email: email, password: password);

    if (data != null) {
      SecureStorage _secureStorage = SecureStorage();
      _secureStorage.write(data['token']);

      notifyListeners();
    }
  }

  // REGISTER
  register(String email, String name, String password) async {
    AuthController auth = AuthController();
    dynamic data =
        await auth.register(email: email, name: name, password: password);

    if (data != null) {
      SecureStorage _secureStorage = SecureStorage();
      _secureStorage.write(data['token']);

      notifyListeners();
    }
  }

  // LOGOUT
  logout() async {
    SecureStorage _secureStorage = SecureStorage();
    _secureStorage.deleteAll();
    _user = null;
    notifyListeners();
  }
}
*/