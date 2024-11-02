import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:servicios_apis/utils/url.dart';

class AuthService {
  static Future<bool> login(String email, String password) async {
    final url = '${Constants.baseUrl}/login';
    final body = jsonEncode({'email': email, 'password': password});

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['accessToken'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        return true;
      } else {
        print('Error: ${response.body}');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> register(String name, String email, String password) async {
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
            headers: {'Content-Type': 'application/json'},
            body: body,
        );

        if (response.statusCode == 201) {
    try {
        final responseData = json.decode(response.body);
        final token = responseData['accessToken']; // Asegúrate de que este campo exista
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        return true; // Registro exitoso
    } catch (e) {
        print('Error al decodificar la respuesta: $e');
        return false;
    }
} else {
    print('Error en registro: ${response.body}');
    return false; // Registro fallido
}
    } catch (e) {
        print('Error de conexión: $e');
        return false; // Error de conexión
    }
  }
}