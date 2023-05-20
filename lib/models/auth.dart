import 'package:flutter/material.dart';

class SignupModel extends ChangeNotifier {
  late String _email;
  late String _firstName;
  late String _password;

  String get email => _email;
  set email(String email) {
    _email = email;
  }

  String get password => _password;
  set password(String password) {
    _password = password;
  }

  String get firstName => _firstName;
  set firstName(String firstName) {
    _firstName = firstName;
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
