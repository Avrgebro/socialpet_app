import 'dart:convert';
import 'dart:io';

import 'package:socialpet/config/constants/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:socialpet/config/constants/app_constants.dart';
import 'package:socialpet/utils/services/secure_storage_service.dart';

class CountryProvider {
  
  static Future<List<Map<String, dynamic>>?> fetchCountries() async {
    final response = await http.get(Uri.parse('${ApiPathConstants.country_base}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
        body['data'].map((i) => i as Map<String, dynamic>)
      );
      return data;
    } else {
      throw Exception('Failed to execute: ${response.statusCode}');
    }
  }
}