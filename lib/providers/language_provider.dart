import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  bool _isArabic = false;

  bool get isArabic => _isArabic;

  Locale get locale => Locale(_isArabic ? 'ar' : 'en');

  void setLanguage(bool value) {
    _isArabic = value;
    notifyListeners();
  }

  void changeLanguage(String code) {
    _isArabic = code == 'ar';
    notifyListeners();
  }

  void toggleLanguage() {
    _isArabic = !_isArabic;
    notifyListeners();
  }
}