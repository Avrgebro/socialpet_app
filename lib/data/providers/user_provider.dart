import 'dart:convert';
import 'dart:io';

import 'package:socialpet/config/constants/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:socialpet/config/constants/app_constants.dart';
import 'package:socialpet/utils/services/secure_storage_service.dart';

class UserProvider {
  
  static Future<Map<String, dynamic>?> fetchUser() async {
    final token = await SecureStorage.getValue(AppConstants.tokenKey);
    final response = await http.get(Uri.parse('${ApiPathConstants.user_base}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + token!
      },
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return decoded as Map<String, dynamic>;
    } else {
      throw Exception('Failed to execute: ${response.statusCode}');
    }
  }
}