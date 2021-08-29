import 'package:socialpet/config/constants/api_path.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  
  Future<String> fetchUser(String uuid) async {

    final response = await http.get(Uri.parse('${ApiPathConstants.user_base}uuid'));
  }
}