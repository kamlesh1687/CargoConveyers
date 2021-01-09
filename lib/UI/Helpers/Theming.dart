import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Color> colorsList = [
  Colors.blue,
  Colors.deepOrange,
  Colors.teal,
  Colors.amber,
  Colors.purple,
  Colors.brown
];

class ThemeProvider extends ChangeNotifier {
  saveColor(index) async {
    var _pref = await SharedPreferences.getInstance();
    _pref.setInt('colorIndex', index);
  }

  loadColor() async {
    var _pref = await SharedPreferences.getInstance();
    int index = _pref.getInt('colorIndex');
    if (index != null) {
      _currentColor = colorsList[index];
    }
    notifyListeners();
  }

  Color _currentColor = Colors.blue;
  Color get currentColor => _currentColor;
  set selectedColor(Color value) {
    _currentColor = value;
    saveColor(colorsList.indexOf(value));
    notifyListeners();
  }
}
