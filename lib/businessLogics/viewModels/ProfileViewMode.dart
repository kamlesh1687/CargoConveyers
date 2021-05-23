import 'dart:convert';

import 'package:cargoconveyers/businessLogics/models/UserModel.dart';
import 'package:cargoconveyers/businessLogics/viewModels/AppState.dart';
import 'package:cargoconveyers/main.dart';

import 'package:cargoconveyers/services/firebaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<UserModel> currentUser = ValueNotifier(UserModel());

enum ScreenLoadingStatus { Loaded, Loading }

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ProfileViewModel extends AppState {
  ProfileViewModel() {
    userData = currentUser.value;
    getLoadUserData(userData.userId);
    print('sdfnkusahfiuerhgfiuaerniufnerkfnbdekjfnekjfbd');
  }

  bool _isNewUser;

  UserModel _userData;

/* ------------------------------- All getter ------------------------------- */
  bool get isNewUser => _isNewUser;

  UserModel get userData => _userData;

/* ------------------------------- All Setter ------------------------------- */

  set isNewUser(value) {
    _isNewUser = value;
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
        .setString("userData", jsonEncode(_user))
        .then((value) => {print("saved succesfully")});
  }

  deleteUserSfData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove("userData");
    userData = null;
    notifyListeners();
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
      userData = _user;
      currentUser.value = _user;
      notifyListeners();
      addDataToSf(_user);

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

      return value;
    });
  }

  Future<String> signupFunc(String _userEmail, String _password) async {
    return firebaseServices.signUp(_userEmail, _password);
  }

  Future<String> signoutFunc() async {
    firebaseServices.signOut();

    resetUserData();

    return 'success';
  }
}
