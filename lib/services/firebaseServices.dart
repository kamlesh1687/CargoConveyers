import 'package:cargoconveyers/businessLogics/models/LoadModel.dart';
import 'package:cargoconveyers/businessLogics/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseServices firebaseServices = FirebaseServices();

class FirebaseServices {
/* ----------------------------- Authentication ----------------------------- */

  Future<String> signUp(String _email, String _pass) async {
    try {
      return await _auth
          .createUserWithEmailAndPassword(email: _email, password: _pass)
          .then((value) {
        return "Done";
      });
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<String> signIn(String _email, String _pass) async {
    try {
      return await _auth
          .signInWithEmailAndPassword(email: _email, password: _pass)
          .then((value) {
        return 'Done';
      });
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }
/* ------------------------------ Get user data ----------------------------- */

  Future<UserModel> getUserData(String userId) async {
    var data =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    UserModel _user = UserModel.fromDocumentSnapshot(documentSnapshot: data);
    return _user;
  }

/* ------------------------------- Load market ------------------------------ */

  Future addLoad(LoadModel _loadModel) async {
    _firestore
        .collection("LoadMarket")
        .doc(_loadModel.requestId)
        .set(_loadModel.toJson())
        .then((value) => print('success'))
        .catchError((err) {
      print(err.message);
      print(err.code);
    });
  }

  Future addLoadToUser(LoadModel _loadModel) async {
    _firestore
        .collection('users')
        .doc(_loadModel.ownerId)
        .collection("LoadMarket")
        .doc(_loadModel.requestId)
        .set(_loadModel.toJson())
        .then((value) => print('success'));
  }

  Future<List<LoadModel>> getLoadsForUser(String _userId) async {
    try {
      QuerySnapshot _qSnap = await _firestore
          .collection('users')
          .doc(_userId)
          .collection("LoadMarket")
          .get()
          .catchError((onError) => print(onError.toString()));
      List<LoadModel> _list = _qSnap.docs
          .map((doc) => LoadModel.fromDocumentSnapshot(documentSnapshot: doc))
          .toList();

      return _list;
    } on StateError catch (e) {
      print(e);
      return null;
    }
  }

  void deleteLoadModel(String loadId, String userId) {
    _firestore
        .collection("LoadMarket")
        .doc(loadId)
        .delete()
        .then((value) => print('success'))
        .catchError((err) {
      print(err.message);
      print(err.code);
    });
    _firestore
        .collection('users')
        .doc(userId)
        .collection("LoadMarket")
        .doc(loadId)
        .delete()
        .then((value) => print('success'))
        .catchError((err) {
      print(err.message);
      print(err.code);
    });
  }

  Future<List<LoadModel>> getLoadMarket() async {
    print('gettint market loads');
    QuerySnapshot _qSnap = await _firestore
        .collection("LoadMarket")
        .orderBy('posTime', descending: true)
        .get();
    List<LoadModel> _list = _qSnap.docs
        .map((doc) => LoadModel.fromDocumentSnapshot(documentSnapshot: doc))
        .toList();

    return _list;
  }
}
