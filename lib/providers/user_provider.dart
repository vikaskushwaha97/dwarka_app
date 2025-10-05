import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String _name = 'Guest User';
  String _email = 'guest@example.com';
  String _phone = '';
  String? _profileImagePath;

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String? get profileImagePath => _profileImagePath;

  void updateProfile(String newName, String newEmail, String newPhone, {String? imagePath}) {
    _name = newName;
    _email = newEmail;
    _phone = newPhone;
    if (imagePath != null) {
      _profileImagePath = imagePath;
    }
    notifyListeners();
  }

  void resetProfile() {
    _name = 'Guest User';
    _email = 'guest@example.com';
    _phone = '';
    _profileImagePath = null;
    notifyListeners();
  }
}