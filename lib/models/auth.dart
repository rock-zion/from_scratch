import 'package:flutter/material.dart';

class SignupModel extends ChangeNotifier {
  String _email = "";
  String _password = "";
  String _fullName = "";

  String get email => _email;
  set email(String email) {
    _email = email;
  }

  String get password => _password;
  set password(String password) {
    _password = password;
  }

  String get fullName => _fullName;
  set fullName(String fullName) {
    _fullName = fullName;
  }
}

// Login Model

class LoginModel extends ChangeNotifier {
  late String _email;
  late String _password;

  String get email => _email;
  set email(String email) {
    _email = email;
  }

  String get password => _password;
  set password(String password) {
    _password = password;
  }
}
