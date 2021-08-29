import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserCredentials{
  final String email;
  final String password;

  UserCredentials({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}