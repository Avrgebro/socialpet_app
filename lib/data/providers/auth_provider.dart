import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:socialpet/config/constants/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:socialpet/config/constants/app_constants.dart';
import 'package:socialpet/utils/enums/socials.dart';
import 'package:socialpet/utils/helpers/user_credentials_helper.dart';
import 'package:socialpet/utils/services/secure_storage_service.dart';

class AuthProvider {
  
  static Future<Map<String, dynamic>?> logInUser(UserCredentials credentials) async {
    final response = await http.post(Uri.parse('${ApiPathConstants.auth_base}/login'),
      body: credentials.toJson(),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        },
    );
    
    final decoded = jsonDecode(response.body);

    if ([401, 200].contains(response.statusCode)) {
      if(decoded['status'] == 'success'){
        return decoded['data'] as Map<String, dynamic>;
      } else if (decoded['status'] == 'error') {
        return new Map<String, dynamic>();
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to execute: ${response.statusCode}');
    }

  }

  static Future<Map<String, dynamic>?> logInUserWithSocial(String email, String uuid) async {

    final response = await http.post(Uri.parse('${ApiPathConstants.auth_base}/login'), body: {
      'email': email,
      'firebase_uuid': uuid 
    });

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
    
    final String? token = await SecureStorage.getValue(AppConstants.tokenKey);
    final response = await http.post(Uri.parse('${ApiPathConstants.auth_base}/logout'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if(decoded['status'] == 'success'){
        return new Map<String, dynamic>();
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to execute: ${response.statusCode}');
    }
    
  }


}