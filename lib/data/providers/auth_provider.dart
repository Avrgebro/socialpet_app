import 'dart:convert';

import 'package:socialpet/config/constants/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:socialpet/utils/helpers/user_credentials_helper.dart';

class UserProvider {
  
  Future<String> logInUser(UserCredentials credentials) async {

    final response = await http.post(Uri.parse('${ApiPathConstants.auth_base}login'), body: credentials.toJson());

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get User');
    }

  }

  
}