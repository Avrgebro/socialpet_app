import 'dart:convert';
import 'dart:io';

import 'package:socialpet/config/constants/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:socialpet/utils/helpers/user_credentials_helper.dart';
import 'package:socialpet/utils/services/secure_storage_service.dart';

class AuthProvider {
  
  static Future<Map<String, dynamic>?> logInUser(UserCredentials credentials) async {

    final response = await http.post(Uri.parse('${ApiPathConstants.auth_base}login'), body: credentials.toJson());

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if(decoded['success']){
        return decoded['data'] as Map<String, dynamic>;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to execute: ${response.statusCode}');
    }

  }

  static Future<Map<String, dynamic>?> logOutUser() async {
    
    final String? token = await SecureStorage.getValue('OAuthToken');
    final response = await http.post(Uri.parse('${ApiPathConstants.auth_base}login'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if(decoded['success']){
        return decoded['data'] as Map<String, dynamic>;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to execute: ${response.statusCode}');
    }
    
  }


}