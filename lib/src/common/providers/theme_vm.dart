import 'package:flutter/cupertino.dart';

class ThemeVM extends ChangeNotifier {
  bool isDark = false;

  /// change theme function
  void switchTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}