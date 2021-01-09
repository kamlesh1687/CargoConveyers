import 'dart:convert';

import 'package:cargoconveyers/businessLogics/models/UserModel.dart';

import 'package:cargoconveyers/services/firebaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ScreenLoadingStatus { Loaded, Loading }

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel() {
    print('data is reseted');
  }
  bool _isServiceProvider;
  bool _isNewUser;

  String _userDataKey = "userData";
  UserModel _userData;

/* ------------------------------- All getter ------------------------------- */
  bool get isNewUser => _isNewUser;

  UserModel get userData => _userData;
  bool get isServiceProvider => _isServiceProvider;

/* ------------------------------- All Setter ------------------------------- */

  set isNewUser(value) {
    _isNewUser = value;
    notifyListeners();
  }

  set isServiceProvider(value) {
    _isServiceProvider = value;
    notifyListeners();
  }

  set userData(value) {
    print('userData is updated');
    _userData = value;
    notifyListeners();
  }

/* --------------------------- Shared Preferences --------------------------- */
  addDataToSf(UserModel _user) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs
        .setString(_userDataKey, jsonEncode(_user))
        .then((value) => {print("saved succesfully")});
  }

  deleteUserSfData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove(_userDataKey);
    _userData = null;
    notifyListeners();
  }

  Future<UserModel> loadDataFromSf() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap;
    final String userStr = _prefs.getString(_userDataKey);
    if (userStr != null) {
      userMap = jsonDecode(userStr);
    }
    if (userMap != null) {
      UserModel _user;
      _user = UserModel.fromJson(userMap);
      userData = _user;
      isServiceProvider = !_user.isShipper;
      print('userData is not null');
      return _user;
    } else {
      print('userData is null');
    }
    notifyListeners();
    return null;
  }

/* ------------------------------ Profile Data ------------------------------ */

  Future<UserModel> getLoadUserData(userId) async {
    return await firebaseServices.getUserData(userId);
  }

  Future<UserModel> getProfileDetails(userId) async {
    print('geting profiledata');
    UserModel _user;
    _user = await firebaseServices.getUserData(userId);

    if (_user != null) {
      _userData = _user;

      addDataToSf(_user);
      notifyListeners();
      return _user;
    }

    return null;
  }

/* --------------------- Add and Update Data to Database -------------------- */

  Future addusermodel(
    _userEmail,
    _userId,
    _userName,
    _userCity,
    _companyName,
    _contactNumber,
    bool isShipper,
  ) async {
    UserModel _user = UserModel(
      city: _userCity,
      contactNumber: _contactNumber,
      email: _userEmail,
      companyName: _companyName,
      userId: _userId,
      userName: _userName,
      isShipper: isShipper,
    );
    if (_user != null) {
      userData = _user;
      isNewUser = true;
      notifyListeners();
      addDataToSf(_user);
    }

    _firestore
        .collection("users")
        .doc(_userId)
        .set(_user.toJson())
        .then((value) {
      print('success');
    }).catchError((err) {
      print(err.message);
      print(err.code);
    });
  }

  void deleteUserModel({String id}) {
    _firestore
        .collection("usermodel")
        .doc(id)
        .delete()
        .then((value) => print('success'))
        .catchError((err) {
      print(err.message);
      print(err.code);
    });
  }

/* ----------------------------- Authentication ----------------------------- */

  resetUserData() {
    deleteUserSfData();
  }

  Future<String> signinFunc(String _userEmail, String _password) async {
    return firebaseServices.signIn(_userEmail, _password).then((value) {
      isNewUser = false;
      notifyListeners();
      return value;
    });
  }

  Future<String> signupFunc(String _userEmail, String _password) async {
    return firebaseServices.signUp(_userEmail, _password);
  }

  Future<String> signoutFunc() async {
    firebaseServices.signOut();

    resetUserData();

    notifyListeners();

    return 'success';
  }
}
