import 'dart:convert';

import 'package:cargoconveyers/businessLogics/models/UserModel.dart';
import 'package:cargoconveyers/businessLogics/viewModels/ProfileViewMode.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  static SharedPreferences preferences;

  Future<bool> initPref() async {
    preferences = await SharedPreferences.getInstance();
    return true;
  }

  Future<UserModel> loadDataFromSf() async {
    Map<String, dynamic> userMap;
    final String userStr = preferences.getString("userData");
    if (userStr != null) {
      userMap = jsonDecode(userStr);
    }
    if (userMap != null) {
      UserModel _user;
      _user = UserModel.fromJson(userMap);
      currentUser.value = _user;

      print('userData is not null');
      return _user;
    } else {
      print('userData is null');
    }

    return null;
  }
}
