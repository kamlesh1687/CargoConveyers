import 'package:flutter/cupertino.dart';

class AppState extends ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(v) {
    _isLoading = v;
    notifyListeners();
  }
}
