import 'package:flutter/cupertino.dart';
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
  //*getLatestData(String token, String userID) async {
  // dynamic data = await AuthController.getProfile(userID);

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
    dynamic data = await Auth.login(email: email, password: password);

    if (data != null) {
      SecureStorage _secureStorage = SecureStorage();
      _secureStorage.write(data['token']);

      notifyListeners();
    }
  }

  // REGISTER
  register(String email, String ic, String password) async {
    dynamic data =
        await Auth.register(email: email, ic: ic, password: password);

    if (data != null) {
      SecureStorage _secureStorage = SecureStorage();
      _secureStorage.write(data['token']);

      notifyListeners();
    }
  }

  // COMPLETE
  /* Future<bool> complete(String userID, XFile? paymentProve, XFile? addressProve,
      Map<String, String> data) async {
    bool res = await AuthController.complete(
        data: data, paymentProve: paymentProve, addressProve: addressProve);

    if (res) {
      User user = User(
        id: data['user_id'],
        personID: data['person_id'],
        mosqueID: data['mosque_id'],
        villageID: data['village_id'],
        name: data['person_name'],
        ic: data['person_ic'],
        phone: data['address'],
        address: data['person_address'],
        occupation: data['person_occupation'],
        status: data['person_status'],
      );

      SecureStorage _secureStorage = SecureStorage();
      String? _token = await _secureStorage.read('token');
      if (_token != null) {
        Box _userBox = await Hive.openBox('user');
        _userBox.put(_token, user);

        _user = user;
        log('completed');
        notifyListeners();
      }
    }

    return res;
  }
*/

  // LOGOUT
  logout() async {
    SecureStorage _secureStorage = SecureStorage();
    _secureStorage.deleteAll();
    _user = null;
    notifyListeners();
  }
}
