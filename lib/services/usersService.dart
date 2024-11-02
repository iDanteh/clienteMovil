import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:servicios_apis/utils/url.dart';

class AuthService {
  Future<void> login(String email, String password) async {
    final url = '${Constants.baseUrl}/login';
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['accessToken'];

        // Guarda el token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
      } else {
        throw Exception('Error: ${response.body}');
      }
    } catch (e) {
      print(e);
      throw Exception('Login failed');
    }
  }

  Future<void> register(String name, String email, String password) async {
    final url = '${Constants.baseUrl}/register';
    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'role': 'user',
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      if (response.statusCode != 200) {
        throw Exception('Error: ${response.body}');
      }
    } catch (e) {
      print(e);
      throw Exception('Registration failed');
    }
  }
}