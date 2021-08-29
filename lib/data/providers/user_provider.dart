import 'dart:convert';

import 'package:socialpet/config/constants/api_path.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  
  static Future<Map<String, dynamic>?> fetchUser(String uuid) async {

    final response = await http.get(Uri.parse('${ApiPathConstants.user_base}uuid'));

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