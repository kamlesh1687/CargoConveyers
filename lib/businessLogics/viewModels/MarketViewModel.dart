import 'package:cargoconveyers/businessLogics/models/LoadInputModel.dart';
import 'package:cargoconveyers/businessLogics/models/LoadModel.dart';

import 'package:cargoconveyers/services/firebaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MarketViewModel extends ChangeNotifier {
  MarketViewModel() {
    print('value');
  }
  deleteUserLoadData() {
    loadFromMarketList = null;
    loadList = null;
  }
/* ------------------------ user selection list data ------------------------ */

  LoadInputData loadInputData = LoadInputData();

/* ------------------------------- Load market ------------------------------ */

/* ---------------------------- Service Provider ---------------------------- */
  List<LoadModel> _loadFromMarketList = [];

  List<LoadModel> get loadFromMarketList => _loadFromMarketList;
  set loadFromMarketList(List<LoadModel> value) {
    _loadFromMarketList = value;
    notifyListeners();
  }

  Future getLoadsFromMarket() async {
    print('checkingmarket');
    _loadFromMarketList = [];

    _loadFromMarketList = await firebaseServices.getLoadMarket();
    print(loadFromMarketList.length);
    notifyListeners();
  }

/* -------------------------- Non Service Provider -------------------------- */
  List<LoadModel> loadList = [];

  Future getMyLoads(userId) async {
    print('gettin my loads');

    loadList = [];

    if (userId != null) {
      loadList = await firebaseServices.getLoadsForUser(userId);
    } else {
      print('usserid is null');
    }
    notifyListeners();
  }

  Future postLoadInMarket(LoadModel marketPost) async {
    if (marketPost != null) {
      //add load to Load market
      firebaseServices.addLoad(marketPost);

      //add load to My loads
      firebaseServices.addLoadToUser(marketPost);

      //load in Myloads
      getMyLoads(marketPost.ownerId);
    }
  }

  Future deleteLoad(index, loadId) async {
    User _user = FirebaseAuth.instance.currentUser;
    firebaseServices.deleteLoadModel(loadId, _user.uid);
    loadList.removeAt(index);
    notifyListeners();
  }

/* ------------------------------ Lorry market ------------------------------ */

}
